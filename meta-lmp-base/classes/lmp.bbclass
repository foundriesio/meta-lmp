USE_FIOTOOLS ?= "1"
FIO_PUSH_CMD ?= "fiopush"
FIO_CHECK_CMD ?= "fiocheck"

# Provided by meta-lmp-bsp or any other compatible BSP layer
include conf/machine/include/lmp-machine-custom.inc

# Allow customizations in partner layers
include conf/machine/include/lmp-partner-custom.inc

# Allow customizations per factory level
include conf/machine/include/lmp-factory-custom.inc

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
	if [ -n "${GARAGE_CUSTOMIZE_TARGET}" ]; then
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
}

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
			if [ "${OSTREE_API_VERSION}" = "v2" ]; then
				"${cmd}" -repo "${OSTREE_REPO}" -creds "${SOTA_PACKED_CREDENTIALS}" -api-version "${OSTREE_API_VERSION}" -cor-id "${GARAGE_TARGET_NAME}-${GARAGE_TARGET_VERSION}"
			else
				"${cmd}" -repo "${OSTREE_REPO}" -creds "${SOTA_PACKED_CREDENTIALS}"
			fi
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
