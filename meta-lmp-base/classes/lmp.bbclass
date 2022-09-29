USE_FIOTOOLS ?= "1"
FIO_PUSH_CMD ?= "fiopush"
FIO_CHECK_CMD ?= "fiocheck"
SOTA_TUF_ROOT_DIR ?= "usr/lib/sota/tuf"

IMAGE_FSTYPES += "${@bb.utils.contains('EFI_PROVIDER', 'systemd-boot', 'ota-esp', ' ', d)}"

# Provided by meta-lmp-bsp or any other compatible BSP layer
include conf/machine/include/lmp-machine-custom.inc

# Allow customizations in partner layers
include conf/machine/include/lmp-partner-custom.inc

# Allow customizations per factory level
include conf/machine/include/lmp-factory-custom.inc

# Rootfs cleanup as a rootfs post process hook, before ostree
sota_var_cleanup() {
	if ${@bb.utils.contains('IMAGE_FSTYPES', 'ota-ext4', 'true', 'false', d)}; then
		# Remove /var stuff (ignored by ostree)
		cd ${IMAGE_ROOTFS}/var
		ostree_rmdir_helper backups
		ostree_rmdir_helper spool
		ostree_rmdir_helper local
		ostree_rmdir_helper lib/misc
		ostree_rmdir_helper volatile
		ostree_rmdir_helper ${@'' if oe.types.boolean('${VOLATILE_LOG_DIR}') else 'log'}
		# symlinks
		rm -v run lock tmp ${@'log' if oe.types.boolean('${VOLATILE_LOG_DIR}') else ''}
		cd -
	fi
}
ROOTFS_POSTPROCESS_COMMAND:append:sota = " sota_var_cleanup; "

provision_root_meta () {
	if [ -n "${SOTA_TUF_ROOT_FETCHER}" ]; then
		if [ -f "${SOTA_TUF_ROOT_FETCHER}" ] && [ -x "${SOTA_TUF_ROOT_FETCHER}" ]; then
			bbplain "Fetching TUF root role metadata to the ostree-based rootfs..."

			FACTORY="${LMP_DEVICE_FACTORY}" \
			SOTA_TUF_ROOT_DIR="${SOTA_TUF_ROOT_DIR}" \
			LOG_FILE="${SOTA_TUF_ROOT_LOG_FILE}" \
				${SOTA_TUF_ROOT_FETCHER}
		else
			bbfatal "Provisioning of TUF root role metadata is turned ON, but the specified metadata fetcher is either doesn't exist or is not executable: ${SOTA_TUF_ROOT_FETCHER}"
		fi
	else
		bbfatal "Provisioning of TUF root role metadata is turned ON, but a metadata fetcher `SOTA_TUF_ROOT_FETCHER` is not defined"
	fi
}

preload_apps () {
	if [ "${COMPOSE_APP_TYPE}" = "restorable" ]; then
		if [ -f "${APP_PRELOADER}" ] && [ -x "${APP_PRELOADER}" ]; then
			bbplain "Preloading Apps of the given Target: ${GARAGE_TARGET_NAME}-${target_version}"

			REGISTRY_SECRETS_FILE="${APP_PRELOAD_REGISTRY_SECRETS_FILE}" \
			TARGET_JSON_FILE="${OTA_SYSROOT}/ostree/deploy/${OSTREE_OSNAME}/var/sota/import/installed_versions" \
			APP_SHORTLIST="${APP_SHORTLIST}" \
			OCI_STORE_PATH="${OTA_SYSROOT}/ostree/deploy/${OSTREE_OSNAME}/var/sota/reset-apps" \
			TOKEN_FILE="${APP_PRELOAD_TOKEN_FILE}" \
			LOG_FILE="${APP_PRELOAD_LOG_FILE}" \
				${APP_PRELOADER}
		else
			bbwarn "Apps preloading is turned ON, but the specified preloader either doesn't exist or is not executable: ${APP_PRELOADER}"
		fi
	else
		bbwarn "Apps preloading is skipped because the preloader doesn't support the given type of Apps: ${COMPOSE_APP_TYPE}"
	fi
}

# Support initial customized target via GARAGE_CUSTOMIZE_TARGET
# This is set by our CI scripts and allows the initial target to populated by
# the build process so it can be incorporated at the first aktualizr-lite run
IMAGE_CMD:ota:append () {
	if [ -n "${GARAGE_CUSTOMIZE_TARGET}" ] && [ -n "${SOTA_PACKED_CREDENTIALS}" ] ; then
		bbplain "Running command(${GARAGE_CUSTOMIZE_TARGET}) to customize target"
		${GARAGE_CUSTOMIZE_TARGET} \
		${OTA_SYSROOT}/ostree/deploy/${OSTREE_OSNAME}/var/sota/import/installed_versions \
			${GARAGE_TARGET_NAME}-${target_version}
	fi

	# systemd-boot support
	if [ "${EFI_PROVIDER}" = "systemd-boot" ]; then
		if [ "${OSTREE_LOADER_LINK}" != "0" ]; then
			bbfatal "Systemd-boot requires OSTREE_LOADER_LINK to be set to '0'"
		fi
		if [ "${OSTREE_SPLIT_BOOT}" != "1" ]; then
			bbfatal "Systemd-boot requires OSTREE_SPLIT_BOOT to be set to '1'"
		fi
		if [ "${OSTREE_BOOTLOADER}" != "none" ]; then
			bbfatal "Systemd-boot requires OSTREE_BOOTLOADER to be set to 'none'"
		fi
		# As upstream doesn't yet support systemd-boot, we have to undo none and change as needed
		ostree config --repo=${OTA_SYSROOT}/ostree/repo unset sysroot.bootloader
		touch ${OTA_SYSROOT}/boot/loader/loader.conf
		# Remove boot symlink as partition is vfat/ESP
		rm -f ${OTA_SYSROOT}/boot/boot
		# Install systemd-boot EFI in ota-boot to allow consumption out of wic
		cp -rf ${IMAGE_ROOTFS}/boot/EFI ${OTA_SYSROOT}/boot
	fi

	# Ostree /boot/loader as link (default) or as directory
	if [ "${OSTREE_LOADER_LINK}" = "0" ]; then
		if [ -h ${OTA_SYSROOT}/boot/loader ]; then
			loader=`readlink ${OTA_SYSROOT}/boot/loader`
			rm -f ${OTA_SYSROOT}/boot/loader
			mv ${OTA_SYSROOT}/boot/${loader} ${OTA_SYSROOT}/boot/loader
			echo -n ${loader} > ${OTA_SYSROOT}/boot/loader/ostree_bootversion
		else
			mkdir -p ${OTA_SYSROOT}/boot/loader
			echo -n "loader.0" > ${OTA_SYSROOT}/boot/loader/ostree_bootversion
		fi
	fi

	# Split content from /boot into a separated folder so it can be consumed by WKS separately
	if [ "${OSTREE_SPLIT_BOOT}" = "1" ]; then
		rm -rf ${OTA_BOOT}
		mv ${OTA_SYSROOT}/boot ${OTA_BOOT}
		mkdir -p ${OTA_SYSROOT}/boot
	fi

	if [ "${APP_PRELOAD_WITHIN_OE_BUILD}" = "1" ]; then
		preload_apps
	fi
}
OTA_BOOT = "${WORKDIR}/ota-boot"
do_image_ota[dirs] += "${OTA_BOOT}"
do_image_ota[cleandirs] += "${OTA_BOOT}"

# Adapted from oe_mkext234fs in image_types.bbclass
oe_mkotaespfs() {
	fstype="$1"
	extra_imagecmd=""

	if [ $# -gt 1 ]; then
		shift
		extra_imagecmd=$@
	fi

	# Create a sparse image block. ESP partition must be 64K blocks.
	bbdebug 1 Executing "dd if=/dev/zero of=${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.$fstype seek=65536 count=0 bs=1024"
	dd if=/dev/zero of=${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.$fstype seek=65536 count=0 bs=1024
	bbdebug 1 "Actual ESP size: `du -s ${OTA_BOOT}`"
	bbdebug 1 "Actual Partition size: `stat -c '%s' ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.$fstype`"
	bbdebug 1 Executing "mkfs.vfat -F 32 -I $extra_imagecmd ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.$fstype "
	mkfs.vfat -F 32 -I $extra_imagecmd ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.$fstype
	mcopy -i ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.$fstype -s ${OTA_BOOT}/* ::/
	# Error codes 0-3 indicate successfull operation of fsck (no errors or errors corrected)
	fsck.vfat -pvfV ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.$fstype
}
do_image_ota_esp[depends] += "dosfstools-native:do_populate_sysroot mtools-native:do_populate_sysroot"
IMAGE_TYPEDEP:ota-esp = "ota"
IMAGE_TYPES += "ota-esp"
EXTRA_IMAGECMD:ota-esp ?= ""
IMAGE_CMD:ota-esp = "oe_mkotaespfs ota-esp ${EXTRA_IMAGECMD}"

# LMP specific cleanups after the main ostree image from meta-updater
IMAGE_CMD:ostree:append () {
	# No need for files under /boot as we use ostree-kernel-initramfs
	rm -rf boot
	mkdir boot

	# No need for var/local as the entire var is bind-mounted
	rm -rf var/local

	# Prefer /usr/lib/tmpfiles.d instead of /etc
	mv usr/etc/tmpfiles.d/00ostree-tmpfiles.conf usr/lib/tmpfiles.d
	# Cover missing /var/rootdirs/home (pending in meta-updater)
	echo "d /var/rootdirs/home 0755 root root -" >> usr/lib/tmpfiles.d/00ostree-tmpfiles.conf

	# Update default home path (compatible with nss alt files)
	sed -i -e 's,:/home,:/var/rootdirs/home,g' usr/etc/passwd
	if [ -f usr/lib/passwd ]; then
		sed -i -e 's,:/home,:/var/rootdirs/home,g' usr/lib/passwd
	fi

	# Support enabling updating files in /boot from /usr/lib/ostree-boot
	if [ "${OSTREE_DEPLOY_USR_OSTREE_BOOT}" = "1" ]; then
		mkdir -p usr/lib/ostree-boot
		touch usr/lib/ostree-boot/.ostree-bootcsumdir-source
	fi

       if [ "${SOTA_TUF_ROOT_PROVISION}" = "1" ]; then
               # fetch root role metadata and store them on the ostree-based filesystem
               provision_root_meta
       else
               bbplain "Provisioning of TUF root role metadata is turned OFF"
       fi
}

# Post ext4 generation logic for luks2 based disk encryption
IMAGE_CMD:ota-ext4:append () {
	if [ "${OSTREE_OTA_EXT4_LUKS}" = "1" ]; then
		if [ -z "${OSTREE_OTA_EXT4_LUKS_PASSPHRASE}" ]; then
			bbfatal "Unable to find passphrase for LUKS-based ota-ext4 (define OSTREE_OTA_EXT4_LUKS_PASSPHRASE)"
		fi
		cp ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.ota-ext4 ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.ota-ext4-orig

		block_size=`dumpe2fs -h ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.ota-ext4 | grep "^Block size" | cut -d ':' -f 2 | tr -d ' '`
		block_count=`dumpe2fs -h ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.ota-ext4 | grep "^Block count" | cut -d ':' -f 2 | tr -d ' '`
		luks_size=33554432 # 32m
		new_block_count=$(expr ${block_count} - $(expr ${luks_size} / ${block_size}))
		bbdebug 1 "Rootfs: block size: $block_size, block count: $block_count"
		bbdebug 1 "Resizing Rootfs: old block count: $block_count, new block count: $new_block_count"
		resize2fs -p ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.ota-ext4 ${new_block_count}
		# Error codes 0-3 indicate successfull operation of fsck (no errors or errors corrected)
		fsck.ext4 -pvfD ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.ota-ext4 || [ $? -le 3 ]
		# After resize2fs we need to make sure the file size (simulating the block device) stays the same
		dd if=/dev/zero of=${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.ota-ext4 seek=$ROOTFS_SIZE count=0 bs=1024

		echo ${OSTREE_OTA_EXT4_LUKS_PASSPHRASE} | cryptsetup reencrypt --encrypt --key-slot 31 --pbkdf-memory ${OSTREE_OTA_EXT4_LUKS_PBKDF2_MEM} --disable-locks --reduce-device-size 32m ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.ota-ext4
		cryptsetup config --label otaroot ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.ota-ext4
		cryptsetup luksDump ${IMGDEPLOYDIR}/${IMAGE_NAME}${IMAGE_NAME_SUFFIX}.ota-ext4
	fi
}
OSTREE_OTA_EXT4_LUKS ?= "0"
OSTREE_OTA_EXT4_LUKS_PBKDF2_MEM ?= "524288"
OSTREE_OTA_EXT4_LUKS_PASSPHRASE ?= "fiopassphrase"
do_image_ota_ext4[depends] += "cryptsetup-native:do_populate_sysroot"

run_fiotool_cmd () {
	if [ -n "${SOTA_PACKED_CREDENTIALS}" ]; then
		if [ -e "${SOTA_PACKED_CREDENTIALS}" ]; then
			# Fallback to the OE built fiopush/fiocheck if FIO_PUSH/CHECK_CMD is not defined or it refers to non-existing or non-executable
			if [ -n "${1}" ] && [ -x "${1}" ]; then
				cmd="${1}"
			else
				cmd="${2}"
			fi
			bbplain "Pushing/checking an ostree repo, cmd: ${cmd}"
			if [ -n "${OSTREE_API_VERSION}" ] && [ "${OSTREE_API_VERSION}" != "v2" ]; then
				bbfatal "The ostreehub version ${OSTREE_API_VERSION} is not supported (OSTREE_API_VERSION=${OSTREE_API_VERSION})"
			fi
			"${cmd}" -repo "${OSTREE_REPO}" -creds "${SOTA_PACKED_CREDENTIALS}" -cor-id "${GARAGE_TARGET_NAME}-${GARAGE_TARGET_VERSION}"
		else
			bbwarn "SOTA_PACKED_CREDENTIALS file does not exist."
		fi
	else
		bbwarn "SOTA_PACKED_CREDENTIALS not set. Please add SOTA_PACKED_CREDENTIALS."
	fi
}

do_image_ostreepush[depends] += "ostreeuploader-native:do_populate_sysroot"
IMAGE_CMD:ostreepush:prepend () {
	if [ "${USE_FIOTOOLS}" = "1" ]; then
		run_fiotool_cmd "${FIO_PUSH_CMD}" "fiopush"
		# force return so garage-push called from meta-updater's IMAGE_CMD:ostreepush is not executed
		return
	fi
}

do_image_garagecheck[depends] += "ostreeuploader-native:do_populate_sysroot"
IMAGE_CMD:garagecheck:prepend () {
	if [ "${USE_FIOTOOLS}" = "1" ]; then
		run_fiotool_cmd "${FIO_CHECK_CMD}" "fiocheck"
		# force return so garage-check called from meta-updater's IMAGE_CMD:garagecheck is not executed
		return
	fi
}

### Utilities

def make_efi_dtb_boot_files(d):
    # Generate IMAGE_EFI_BOOT_FILES entries for device tree files listed in
    # KERNEL_DEVICETREE, to be available at the ESP/dtb folder (for u-boot).
    # Use only the basename for dtb files:
    alldtbs = d.getVar('KERNEL_DEVICETREE')

    # DTBs may be built out of kernel with devicetree.bbclass
    if not alldtbs:
        return ''

    def transform(dtb):
        if not (dtb.endswith('dtb') or dtb.endswith('dtbo')):
            bb.error("KERNEL_DEVICETREE entry %s is not a .dtb or .dtbo file." % (dtb) )
        return os.path.basename(dtb) + ';dtb/' + os.path.basename(dtb)

    return ' '.join([transform(dtb) for dtb in alldtbs.split() if dtb])

def make_efi_cer_boot_files(d):
    # Generate IMAGE_EFI_BOOT_FILES entries for certificate files available
    # at the UEFI_SIGN_KEYDIR folder.
    keydir = d.getVar('UEFI_SIGN_KEYDIR')
    if not keydir:
        return ''

    def transform(cer):
        cer_path = os.path.join(keydir, cer + '.cer')
        if not os.access(cer_path, os.R_OK):
            bb.fatal("Unable to find certificate '%s.cer' in '%s'" % (cer, keydir))
        return cer_path + ';uefi_certs/' + os.path.basename(cer_path)

    return ' '.join([transform(cer) for cer in ['PK', 'KEK', 'DB', 'DBX']])
