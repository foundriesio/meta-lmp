# OSF LMP specific configuration

# Beaglebone
OSTREE_KERNEL_ARGS_append_beaglebone-yocto = " console=ttyO0,115200n8"
KERNEL_DEVICETREE_append_beaglebone-yocto = " am335x-boneblack-wireless.dtb"
IMAGE_BOOT_FILES_append_beaglebone-yocto = " boot.scr uEnv.txt ${KERNEL_DEVICETREE}"

# Dragonboard (DB410/DB820), u-boot as boot image and rootfs on sdcard
UBOOT_MACHINE_dragonboard-410c = "dragonboard410c_defconfig"
IMAGE_BOOT_FILES_append_dragonboard-410c = " boot.scr uEnv.txt apq8016-sbc.dtb"
OSTREE_KERNEL_ARGS_append_dragonboard-410c = " console=tty0 console=ttyMSM0,115200n8 androidboot.baseband=apq mdss_mdp.panel=0:dsi:0:"
WKS_FILES_sota_dragonboard-410c = "sdimage-sota.wks"
UBOOT_MACHINE_dragonboard-820c = "dragonboard820c_defconfig"
IMAGE_BOOT_FILES_append_dragonboard-820c = " boot.scr uEnv.txt apq8096-db820c.dtb"
OSTREE_KERNEL_ARGS_append_dragonboard-820c = " console=tty0 console=ttyMSM0,115200n8 androidboot.baseband=apq mdss_mdp.panel=0"
WKS_FILES_sota_dragonboard-820c = "sdimage-sota.wks"

# HiKey
CMDLINE_remove_hikey = "quiet"
PREFERRED_VERSION_grub_hikey = "git"
OSTREE_BOOTLOADER_hikey = "grub"
OSTREE_KERNEL_ARGS_append_hikey = " console=tty0 console=ttyAMA3,115200n8 efi=noruntime"
KERNEL_IMAGETYPE_hikey = "Image.gz"
IMAGE_FSTYPES_remove_hikey = "wic.gz wic.bmap"

# Raspberry Pi
RPI_USE_U_BOOT = "1"
VC4DTBO_raspberrypi3-64 = "vc4-kms-v3d"
IMAGE_FSTYPES_remove_rpi = " ext3 rpi-sdimg"
IMAGE_BOOT_FILES_append_rpi = " ${@make_dtb_boot_files(d)} boot.scr uEnv.txt"
KERNEL_IMAGETYPE_sota_raspberrypi0-wifi = "zImage"
KERNEL_IMAGETYPE_sota_raspberrypi3-64 = "Image.gz"
## We don't want fitimage by default yet as it blocks overlay support
KERNEL_CLASSES_remove_rpi = "kernel-fitimage"
KERNEL_DEVICETREE_raspberrypi0-wifi_sota = "bcm2708-rpi-0-w.dtb bcm2835-rpi-zero-w.dtb \
    overlays/i2c-rtc.dtbo overlays/rpi-ft5406.dtbo overlays/vc4-kms-v3d.dtbo overlays/vc4-fkms-v3d.dtbo \
    overlays/pitft22.dtbo overlays/pitft28-resistive.dtbo overlays/pitft35-resistive.dtbo \
    overlays/w1-gpio.dtbo overlays/w1-gpio-pullup.dtbo overlays/at86rf233.dtbo \
"
KERNEL_DEVICETREE_raspberrypi3-64_sota = "\
    broadcom/bcm2710-rpi-3-b.dtb broadcom/bcm2837-rpi-3-b.dtb broadcom/bcm2710-rpi-3-b-plus.dtb \
    overlays/i2c-rtc.dtbo overlays/rpi-ft5406.dtbo overlays/vc4-kms-v3d.dtbo overlays/vc4-fkms-v3d.dtbo \
    overlays/pitft22.dtbo overlays/pitft28-resistive.dtbo overlays/pitft35-resistive.dtbo \
    overlays/w1-gpio.dtbo overlays/w1-gpio-pullup.dtbo overlays/at86rf233.dtbo \
"
OSTREE_KERNEL_ARGS_sota_rpi = "root=LABEL=otaroot rootfstype=ext4"

# RISC-V targets
## QEMU target doesn't support complete disk images
IMAGE_FSTYPES_remove_qemuriscv64 = "wic.gz wic.bmap"
INITRAMFS_IMAGE_BUNDLE_qemuriscv64 = "1"
KERNEL_INITRAMFS_qemuriscv64 = '-initramfs'
RISCV_BBL_PAYLOAD_qemuriscv64 = "${KERNEL_IMAGETYPE}${KERNEL_INITRAMFS}-${MACHINE}.bin"

# Intel
IMAGE_INSTALL_remove_intel-corei7-64 = " minnowboard-efi-startup"
OSTREE_KERNEL_ARGS_append_intel-corei7-64 = " console=ttyS0,115200"
EFI_PROVIDER_intel-corei7-64 = "grub-efi"
WKS_FILE_append_intel-corei7-64 = "efidisk-sota.wks"

# Toradex (support both NAND and eMMC targets with one single image)
OSTREE_KERNEL_ARGS_append_colibri-imx7 = " console=tty1 console=ttymxc0,115200"
EXTRA_IMAGEDEPENDS_append_colibri-imx7 = " u-boot-script-toradex"
IMAGE_BOOT_FILES_append_colibri-imx7 = " boot.scr uEnv.txt u-boot-colibri-imx7.imx;u-boot-nand.imx u-boot-colibri-imx7.imx-sd;u-boot-emmc.imx ${MACHINE_ARCH}/*;${MACHINE_ARCH}"

# cl-som-imx7 (IOT-GATE-iMX7)
OSTREE_KERNEL_ARGS_append_cl-som-imx7 = " console=tty1 console=ttymxc0,115200"
IMAGE_BOOT_FILES_append_cl-som-imx7 = " boot.scr uEnv.txt ${KERNEL_DEVICETREE}"
WKS_FILE_sota_cl-som-imx7 = "sdimage-imx7-spl-sota.wks"

# cubox-i (hummingboard)
OSTREE_KERNEL_ARGS_append_cubox-i = " console=tty1 console=ttymxc0,115200"
KERNEL_DEVICETREE_append_cubox-i = " \
    imx6dl-hummingboard2-som-v15.dtb imx6q-hummingboard2-som-v15.dtb \
    imx6dl-hummingboard2-emmc-som-v15.dtb imx6q-hummingboard2-emmc-som-v15.dtb \
    imx6dl-hummingboard2.dtb imx6q-hummingboard2.dtb \
"
IMAGE_BOOT_FILES_append_cubox-i = " boot.scr uEnv.txt ${KERNEL_DEVICETREE}"
WKS_FILES_sota_cubox-i = "sdimage-imx6-spl-sota.wks"
UBOOT_EXTLINUX_cubox-i = ""

# Cross machines / BSPs
## Drop IMX BSP that is not needed
MACHINE_EXTRA_RRECOMMENDS_remove_imx = "imx-alsa-plugins"
## No need to install u-boot, already a WKS dependency
MACHINE_ESSENTIAL_EXTRA_RDEPENDS_remove_imx = "u-boot-fslc"
