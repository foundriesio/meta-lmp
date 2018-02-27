# OSF LMP specific configuration

# Beaglebone
IMAGE_FSTYPES_append_beaglebone-yocto = " wic.gz"
IMAGE_FSTYPES_remove_beaglebone-yocto = " wic"

# Dragonboard (DB410/DB820)
QCOM_BOOTIMG_ROOTFS_dragonboard-820c ?= "sda9"

# HiKey
CMDLINE_remove_hikey = "quiet"
PREFERRED_VERSION_grub_hikey = "git"

# Raspberry Pi
RPI_USE_U_BOOT = "1"
VC4DTBO_raspberrypi3-64 = "vc4-kms-v3d"
IMAGE_FSTYPES_append_rpi = " ext4.gz wic.gz wic.bmap"
IMAGE_FSTYPES_remove_rpi = " ext3 rpi-sdimg"
WKS_FILE_rpi = "raspberrypi.wks"

# Intel
IMAGE_FSTYPES_append_intel-corei7-64 = " ext4.gz wic.gz"
IMAGE_FSTYPES_remove_intel-corei7-64 = " ext4 wic"
EFI_PROVIDER_intel-corei7-64 = "grub-efi"
WKS_FILE_intel-corei7-64 = "efidisk.wks"

# Cross machines / BSPs
## Drop IMX BSP that is not needed
MACHINE_EXTRA_RRECOMMENDS_remove = "imx-alsa-plugins"
## Workaround for https://lists.yoctoproject.org/pipermail/meta-freescale/2018-February/022104.html
BRCM_FWDIR_imx = "${nonarch_base_libdir}/firmware/brcm"
