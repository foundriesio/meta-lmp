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

	if [ "${DOCKER_COMPOSE_APP_PRELOAD}" = "1" ]; then
		if [ -n "${APP_IMAGES_PRELOADER}" ]; then
			bbplain "Preloading container images of the given target's apps"

			mkdir -p ${OTA_SYSROOT}/ostree/deploy/${OSTREE_OSNAME}/var/lib/docker

			${APP_IMAGES_PRELOADER} \
				${OTA_SYSROOT}/ostree/deploy/${OSTREE_OSNAME}/var/sota/import/installed_versions \
				${OTA_SYSROOT}/ostree/deploy/${OSTREE_OSNAME}/var/lib/docker \
				--images-root-dir="${APP_IMAGES_ROOT_DIR}" \
				--apps-tree-dir="${OTA_SYSROOT}/ostree/deploy/${OSTREE_OSNAME}/var/sota/compose-apps-tree" \
				--apps-root-dir="${OTA_SYSROOT}/ostree/deploy/${OSTREE_OSNAME}/var/sota/compose-apps" \
				--factory="${LMP_DEVICE_FACTORY}" \
				--log-file="${APP_IMAGES_PRELOAD_LOG_FILE}"
		else
			bbwarn "Compose app preloading is turned on but an app preloader is not specified"
		fi
	fi
}

# LMP specific cleanups after the main ostree image from meta-updater
IMAGE_CMD_ostree_append () {
	# No need for var/local as the entire var is bind-mounted
	rm -rf var/local

	# Prefer /usr/lib/tmpfiles.d instead of /etc
	mv usr/etc/tmpfiles.d/00ostree-tmpfiles.conf usr/lib/tmpfiles.d

	# Update default home path
	sed -i -e 's,:/home,:/var/rootdirs/home,g' usr/etc/passwd
}
