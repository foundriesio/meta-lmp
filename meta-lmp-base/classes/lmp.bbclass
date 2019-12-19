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

ROOTFS_POSTPROCESS_COMMAND += "sota_fstab_update; "
