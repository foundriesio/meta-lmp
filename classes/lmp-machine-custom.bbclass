# LMP specific configuration

# Beaglebone
OSTREE_KERNEL_ARGS_append_beaglebone-yocto = " console=ttyO0,115200n8"
KERNEL_DEVICETREE_append_beaglebone-yocto = " am335x-boneblack-wireless.dtb"
IMAGE_BOOT_FILES_beaglebone-yocto = "u-boot.img MLO boot.scr uEnv.txt"
KERNEL_IMAGETYPE_beaglebone-yocto = "fitImage"
KERNEL_CLASSES_beaglebone-yocto = " kernel-fitimage "
OSTREE_KERNEL_beaglebone-yocto = "${KERNEL_IMAGETYPE}-${INITRAMFS_IMAGE}-${MACHINE}-${MACHINE}"
## beaglebone-yocto.conf appends kernel-image-zimage by default
IMAGE_INSTALL_remove_beaglebone-yocto = "kernel-image-zimage"

# Dragonboard 410c, u-boot as boot image and rootfs on sdcard
OSTREE_KERNEL_ARGS_append_dragonboard-410c = " console=tty0 console=ttyMSM0,115200n8 androidboot.baseband=apq mdss_mdp.panel=0:dsi:0:"
IMAGE_BOOT_FILES_append_dragonboard-410c = " boot.scr uEnv.txt"
KERNEL_IMAGETYPE_dragonboard-410c = "fitImage"
KERNEL_CLASSES_dragonboard-410c = " kernel-fitimage "
OSTREE_KERNEL_dragonboard-410c = "${KERNEL_IMAGETYPE}-${INITRAMFS_IMAGE}-${MACHINE}-${MACHINE}"
WKS_FILES_sota_dragonboard-410c = "sdimage-sota.wks"
UBOOT_ENTRYPOINT_dragonboard-410c = "0x81000000"
UBOOT_DTB_LOADADDRESS_dragonboard-410c = "0x83000000"
UBOOT_RD_LOADADDRESS_dragonboard-410c = "0x84000000"

# Dragonboard 820c, u-boot as boot image and rootfs on sdcard
IMAGE_BOOT_FILES_append_dragonboard-820c = " boot.scr uEnv.txt"
OSTREE_KERNEL_ARGS_append_dragonboard-820c = " console=tty0 console=ttyMSM0,115200n8 androidboot.baseband=apq mdss_mdp.panel=0"
KERNEL_IMAGETYPE_dragonboard-820c = "fitImage"
KERNEL_CLASSES_dragonboard-820c = " kernel-fitimage "
OSTREE_KERNEL_dragonboard-820c = "${KERNEL_IMAGETYPE}-${INITRAMFS_IMAGE}-${MACHINE}-${MACHINE}"
WKS_FILES_sota_dragonboard-820c = "sdimage-sota.wks"
UBOOT_ENTRYPOINT_dragonboard-820c = "0x81000000"
UBOOT_DTB_LOADADDRESS_dragonboard-820c = "0x83000000"
UBOOT_RD_LOADADDRESS_dragonboard-820c = "0x84000000"

# HiKey
CMDLINE_remove_hikey = "quiet"
OSTREE_BOOTLOADER_hikey = "grub"
OSTREE_KERNEL_ARGS_append_hikey = " console=tty0 console=ttyAMA3,115200n8 efi=noruntime"
OSTREE_DEPLOY_DEVICETREE_hikey = "1"
KERNEL_IMAGETYPE_hikey = "Image.gz"
IMAGE_FSTYPES_remove_hikey = "wic wic.gz wic.bmap"

# Hikey960
CMDLINE_remove_hikey960 = "quiet"
OSTREE_BOOTLOADER_hikey960 = "grub"
OSTREE_KERNEL_ARGS_append_hikey = " console=tty0 console=ttyAMA6,115200n8 efi=noruntime"
OSTREE_DEPLOY_DEVICETREE_hikey960 = "1"
KERNEL_IMAGETYPE_hikey960 = "Image.gz"
IMAGE_FSTYPES_remove_hikey960 = "wic wic.gz wic.bmap"

# Raspberry Pi
IMAGE_FSTYPES_remove_rpi = "ext3"
IMAGE_BOOT_FILES_append_rpi = " boot.scr uEnv.txt"
## Rollback is not yet supported on rpi
SOTA_CLIENT_FEATURES_remove_rpi = "ubootenv"
KERNEL_DEVICETREE_raspberrypi0-wifi = "bcm2708-rpi-0-w.dtb overlays/rpi-ft5406.dtbo overlays/rpi-7inch.dtbo overlays/rpi-7inch-flip.dtbo"
KERNEL_DEVICETREE_raspberrypi3_sota = "${RPI_KERNEL_DEVICETREE} overlays/vc4-kms-v3d.dtbo overlays/rpi-ft5406.dtbo overlays/rpi-7inch.dtbo overlays/rpi-7inch-flip.dtbo"
## Mimic meta-raspberrypi behavior
KERNEL_SERIAL_rpi = "${@oe.utils.conditional("ENABLE_UART", "1", "console=ttyS0,115200", "", d)}"
OSTREE_KERNEL_ARGS_sota_raspberrypi0-wifi = "8250.nr_uarts=1 vc_mem.mem_base=0x1ec00000 vc_mem.mem_size=0x20000000 dwc_otg.lpm_enable=0 console=tty1 ${KERNEL_SERIAL} root=LABEL=otaroot rootfstype=ext4"
OSTREE_KERNEL_ARGS_sota_raspberrypi3 = "8250.nr_uarts=1 cma=256M vc_mem.mem_base=0x3ec00000 vc_mem.mem_size=0x40000000 dwc_otg.lpm_enable=0 console=tty1 ${KERNEL_SERIAL} root=LABEL=otaroot rootfstype=ext4"
## U-Boot entrypoints for rpi
UBOOT_ENTRYPOINT_rpi = "0x00008000"
UBOOT_DTB_LOADADDRESS_rpi = "0x02600000"
UBOOT_DTBO_LOADADDRESS_rpi = "0x026d0000"

# RISC-V targets
## QEMU target doesn't support complete disk images
IMAGE_FSTYPES_remove_qemuriscv64 = "wic wic.gz wic.bmap"
INITRAMFS_IMAGE_BUNDLE_qemuriscv64 = "1"
KERNEL_INITRAMFS_qemuriscv64 = '-initramfs'
RISCV_BBL_PAYLOAD_qemuriscv64 = "${KERNEL_IMAGETYPE}${KERNEL_INITRAMFS}-${MACHINE}.bin"
## Freedom U540 target doesn't yet support standard bootloaders (e.g. u-boot)
INITRAMFS_IMAGE_BUNDLE_freedom-u540 = "1"
KERNEL_INITRAMFS_freedom-u540 = '-initramfs'
RISCV_BBL_PAYLOAD_freedom-u540 = "${KERNEL_IMAGETYPE}${KERNEL_INITRAMFS}-${MACHINE}.bin"
WKS_FILE_sota_freedom-u540 = "freedom-u540-bbl-sota.wks"

# QEMU ARM
PREFERRED_PROVIDER_virtual/bootloader_qemuarm64 = "u-boot"
UBOOT_MACHINE_qemuarm64 = "qemu_arm64_defconfig"
IMAGE_BOOT_FILES_qemuarm64 = "boot.scr uEnv.txt"
KERNEL_IMAGETYPE_qemuarm64 = "fitImage"
KERNEL_CLASSES_qemuarm64 = " kernel-fitimage "
OSTREE_KERNEL_qemuarm64 = "${KERNEL_IMAGETYPE}-${INITRAMFS_IMAGE}-${MACHINE}-${MACHINE}"
OSTREE_KERNEL_ARGS_append_qemuarm64 = " console=ttyAMA0"
UBOOT_ENTRYPOINT_qemuarm64 = "0x40080000"
MACHINE_FEATURES_append_qemuarm64 = " optee"
EXTRA_IMAGEDEPENDS_append_qemuarm64 = " atf"
QB_MACHINE_qemuarm64 = "-machine virt,secure=on"
## Use same minimal memory amount as suggested by op-tee
QB_MEM_qemuarm64 = "-m 1057"
QB_DRIVE_TYPE_qemuarm64 = "/dev/vd"
## Bios/bl1.bin is ATF, which requires semihosting for the remaining boot artifacts
QB_OPT_APPEND_qemuarm64 = "-no-acpi -bios bl1.bin -d unimp -semihosting-config enable,target=native"

# Intel
IMAGE_INSTALL_remove_intel-corei7-64 = " minnowboard-efi-startup"
OSTREE_KERNEL_ARGS_append_intel-corei7-64 = " console=ttyS0,115200"
EFI_PROVIDER_intel-corei7-64 = "grub-efi"
WKS_FILE_append_intel-corei7-64 = " efidisk-sota.wks"

# Toradex Colibri iMX7 (support both NAND and eMMC targets with one single image)
OSTREE_KERNEL_ARGS_append_colibri-imx7 = " console=tty1 console=ttymxc0,115200"
EXTRA_IMAGEDEPENDS_append_colibri-imx7 = " u-boot-script-toradex"
IMAGE_BOOT_FILES_colibri-imx7 = "boot.scr uEnv.txt u-boot-colibri-imx7.imx;u-boot-nand.imx u-boot-colibri-imx7.imx-sd;u-boot-emmc.imx ${MACHINE_ARCH}/*;${MACHINE_ARCH}"
KERNEL_IMAGETYPE_colibri-imx7 = "fitImage"
KERNEL_CLASSES_colibri-imx7 = " kernel-fitimage "
OSTREE_KERNEL_colibri-imx7 = "${KERNEL_IMAGETYPE}-${INITRAMFS_IMAGE}-${MACHINE}-${MACHINE}"
UBOOT_DTB_LOADADDRESS_colibri-imx7 = "0x82000000"
UBOOT_RD_LOADADDRESS_colibri-imx7 = "0x82100000"

# cl-som-imx7 (IOT-GATE-iMX7)
OSTREE_KERNEL_ARGS_append_cl-som-imx7 = " console=tty1 console=ttymxc0,115200"
IMAGE_BOOT_FILES_append_cl-som-imx7 = " boot.scr uEnv.txt"
KERNEL_IMAGETYPE_cl-som-imx7 = "fitImage"
KERNEL_CLASSES_cl-som-imx7 = " kernel-fitimage "
OSTREE_KERNEL_cl-som-imx7 = "${KERNEL_IMAGETYPE}-${INITRAMFS_IMAGE}-${MACHINE}-${MACHINE}"
UBOOT_DTB_LOADADDRESS_cl-som-imx7 = "0x82000000"
UBOOT_RD_LOADADDRESS_cl-som-imx7 = "0x82100000"
WKS_FILE_sota_cl-som-imx7 = "sdimage-imx7-spl-sota.wks"

# Toradex Apalis iMX6
OSTREE_KERNEL_ARGS_append_apalis-imx6 = " console=tty1 console=ttymxc0,115200"
EXTRA_IMAGEDEPENDS_append_apalis-imx6 = " u-boot-script-toradex"
IMAGE_BOOT_FILES_apalis-imx6 = "boot.scr uEnv.txt SPL u-boot.imx-spl ${MACHINE_ARCH}/flash_blk.img;flash_blk.img"
KERNEL_IMAGETYPE_apalis-imx6 = "fitImage"
KERNEL_CLASSES_apalis-imx6 = " kernel-fitimage "
OSTREE_KERNEL_apalis-imx6 = "${KERNEL_IMAGETYPE}-${INITRAMFS_IMAGE}-${MACHINE}-${MACHINE}"
UBOOT_DTB_LOADADDRESS_apalis-imx6 = "0x12f00000"
UBOOT_RD_LOADADDRESS_apalis-imx6 = "0x13000000"

# cubox-i (hummingboard)
OSTREE_KERNEL_ARGS_append_cubox-i = " console=tty1 console=ttymxc0,115200"
KERNEL_DEVICETREE_append_cubox-i = " \
    imx6dl-hummingboard2-som-v15.dtb imx6q-hummingboard2-som-v15.dtb \
    imx6dl-hummingboard2-emmc-som-v15.dtb imx6q-hummingboard2-emmc-som-v15.dtb \
    imx6dl-hummingboard2.dtb imx6q-hummingboard2.dtb \
"
IMAGE_BOOT_FILES_append_cubox-i = " boot.scr uEnv.txt"
KERNEL_IMAGETYPE_cubox-i = "fitImage"
KERNEL_CLASSES_cubox-i = " kernel-fitimage "
OSTREE_KERNEL_cubox-i = "${KERNEL_IMAGETYPE}-${INITRAMFS_IMAGE}-${MACHINE}-${MACHINE}"
UBOOT_DTB_LOADADDRESS_cubox-i = "0x18000000"
UBOOT_RD_LOADADDRESS_cubox-i = "0x13000000"
WKS_FILES_sota_cubox-i = "sdimage-imx6-spl-sota.wks"
UBOOT_EXTLINUX_cubox-i = ""

# Cross machines / BSPs
## Drop IMX BSP that is not needed
MACHINE_EXTRA_RRECOMMENDS_remove_imx = "imx-alsa-plugins"
## No need to install u-boot, already a WKS dependency
MACHINE_ESSENTIAL_EXTRA_RDEPENDS_remove_imx = "u-boot-fslc"
