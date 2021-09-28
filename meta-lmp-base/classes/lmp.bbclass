# Provided by meta-lmp-bsp or any other compatible BSP layer
include conf/machine/include/lmp-machine-custom.inc

# Allow customizations per factory level
include conf/machine/include/lmp-factory-custom.inc

# Done as a rootfs post process hook in order to be part of the ostree image
sota_fstab_update() {
	if [ -n "${EFI_PROVIDER}" ]; then
		echo "LABEL=efi /boot/efi vfat umask=0077 0 1" >> ${IMAGE_ROOTFS}/etc/fstab
	fi
}

ROOTFS_POSTPROCESS_COMMAND_append_sota = " sota_fstab_update; "

# Support initial customized target via GARAGE_CUSTOMIZE_TARGET
# This is set by our CI scripts and allows the initial target to populated by
# the build process so it can be incorporated at the first aktualizr-lite run
IMAGE_CMD_ota_append () {
	if [ -n "${GARAGE_CUSTOMIZE_TARGET}" ]; then
		bbplain "Running command(${GARAGE_CUSTOMIZE_TARGET}) to customize target"
		${GARAGE_CUSTOMIZE_TARGET} \
		${OTA_SYSROOT}/ostree/deploy/${OSTREE_OSNAME}/var/sota/import/installed_versions \
			${GARAGE_TARGET_NAME}-${target_version}
	fi
}

# LMP specific cleanups after the main ostree image from meta-updater
IMAGE_CMD_ostree_append () {
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
}

run_fiotool_cmd () {
	if [ -n "${SOTA_PACKED_CREDENTIALS}" ]; then
                if [ -e "${SOTA_PACKED_CREDENTIALS}" ]; then
			if [ "${OSTREE_API_VERSION}" = "v2" ]; then
				"${1}" -repo "${OSTREE_REPO}" -creds "${SOTA_PACKED_CREDENTIALS}" -api-version "${OSTREE_API_VERSION}" -cor-id "${GARAGE_TARGET_NAME}-${GARAGE_TARGET_VERSION}"
			else
				"${1}" -repo "${OSTREE_REPO}" -creds "${SOTA_PACKED_CREDENTIALS}"
			fi
                else
                        bbwarn "SOTA_PACKED_CREDENTIALS file does not exist."
                fi
        else
                bbwarn "SOTA_PACKED_CREDENTIALS not set. Please add SOTA_PACKED_CREDENTIALS."
        fi
}

do_image_ostreepush[depends] += "ostreeuploader-native:do_populate_sysroot"
IMAGE_CMD_ostreepush_prepend () {
	if [ "${USE_FIOTOOLS}" = "1" ]; then
		run_fiotool_cmd "fiopush"
		# force return so garage-push called from meta-updater's IMAGE_CMD_ostreepush is not executed
		return
	fi
}

do_image_garagecheck[depends] += "ostreeuploader-native:do_populate_sysroot"
IMAGE_CMD_garagecheck_prepend () {
	if [ "${USE_FIOTOOLS}" = "1" ]; then
		run_fiotool_cmd "fiocheck"
		# force return so garage-check called from meta-updater's IMAGE_CMD_garagecheck is not executed
		return
	fi
}
