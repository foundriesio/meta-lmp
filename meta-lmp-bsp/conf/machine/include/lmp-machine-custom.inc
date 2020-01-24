# LMP specific configuration

# Beaglebone
PREFERRED_PROVIDER_virtual/bootloader_beaglebone-yocto = "u-boot-fio"
PREFERRED_PROVIDER_u-boot-fw-utils_beaglebone-yocto = "u-boot-fio-fw-utils"
PREFERRED_RPROVIDER_u-boot-fw-utils_beaglebone-yocto = "u-boot-fio-fw-utils"
SOTA_CLIENT_FEATURES_append_beaglebone-yocto = " ubootenv"
OSTREE_KERNEL_ARGS_beaglebone-yocto ?= "console=ttyS0,115200n8 ${OSTREE_KERNEL_ARGS_COMMON}"
KERNEL_DEVICETREE_append_beaglebone-yocto = " am335x-boneblack-wireless.dtb"
IMAGE_BOOT_FILES_beaglebone-yocto = "u-boot.img MLO boot.scr uEnv.txt"
KERNEL_IMAGETYPE_beaglebone-yocto = "fitImage"
KERNEL_CLASSES_beaglebone-yocto = " kernel-lmp-fitimage "
OSTREE_KERNEL_beaglebone-yocto = "${KERNEL_IMAGETYPE}-${INITRAMFS_IMAGE}-${MACHINE}-${MACHINE}"
## beaglebone-yocto.conf appends kernel-image-zimage by default
IMAGE_INSTALL_remove_beaglebone-yocto = "kernel-image-zimage"

# Raspberry Pi
PREFERRED_PROVIDER_virtual/bootloader_rpi = "u-boot-fio"
PREFERRED_PROVIDER_u-boot-fw-utils_rpi = "u-boot-fio-fw-utils"
PREFERRED_RPROVIDER_u-boot-fw-utils_rpi = "u-boot-fio-fw-utils"
SOTA_CLIENT_FEATURES_append_rpi = " ubootenv"
WKS_FILE_DEPENDS_BOOTLOADERS_rpi = "virtual/bootloader"
PREFERRED_PROVIDER_virtual/dtb_rpi ?= "lmp-device-tree"
IMAGE_FSTYPES_remove_rpi = "ext3 rpi-sdimg"
IMAGE_BOOT_FILES_rpi = "bcm2835-bootfiles/* u-boot.bin;${SDIMG_KERNELIMAGE} ${@make_dtb_boot_files(d)} boot.scr uEnv.txt"
KERNEL_CLASSES_rpi = " kernel-lmp-fitimage "
OSTREE_KERNEL_rpi = "${KERNEL_IMAGETYPE}-${INITRAMFS_IMAGE}-${MACHINE}-${MACHINE}"
KERNEL_IMAGETYPE_rpi = "fitImage"
KERNEL_DEVICETREE_COMMON_RPI ?= "overlays/vc4-kms-v3d.dtbo overlays/vc4-fkms-v3d.dtbo overlays/rpi-ft5406.dtbo overlays/pi3-disable-bt.dtbo overlays/mcp2515-can0.dtbo"
KERNEL_DEVICETREE_raspberrypi3 ?= "bcm2710-rpi-3-b.dtb bcm2710-rpi-3-b-plus.dtb bcm2710-rpi-cm3.dtb ${KERNEL_DEVICETREE_COMMON_RPI}"
KERNEL_DEVICETREE_raspberrypi3-64 ?= "broadcom/bcm2710-rpi-3-b.dtb broadcom/bcm2710-rpi-3-b-plus.dtb broadcom/bcm2710-rpi-cm3.dtb ${KERNEL_DEVICETREE_COMMON_RPI}"
KERNEL_DEVICETREE_raspberrypi-cm3 ?= "bcm2710-rpi-cm3.dtb ${KERNEL_DEVICETREE_COMMON_RPI}"
KERNEL_DEVICETREE_raspberrypi4 ?= "bcm2711-rpi-4-b.dtb ${KERNEL_DEVICETREE_COMMON_RPI}"
KERNEL_DEVICETREE_raspberrypi4-64 ?= "broadcom/bcm2711-rpi-4-b.dtb ${KERNEL_DEVICETREE_COMMON_RPI}"
## Mimic meta-raspberrypi behavior
KERNEL_SERIAL_rpi ?= "${@oe.utils.conditional("ENABLE_UART", "1", "console=ttyS0,115200", "", d)}"
KERNEL_SERIAL_raspberrypi-cm3 ?= "console=ttyAMA0,115200"
OSTREE_KERNEL_ARGS_COMMON_RPI ?= "coherent_pool=1M 8250.nr_uarts=1 dwc_otg.lpm_enable=0 console=tty1 ${KERNEL_SERIAL} ${OSTREE_KERNEL_ARGS_COMMON}"
OSTREE_KERNEL_ARGS_raspberrypi3 ?= "cma=256M vc_mem.mem_base=0x3ec00000 vc_mem.mem_size=0x40000000 ${OSTREE_KERNEL_ARGS_COMMON_RPI}"
OSTREE_KERNEL_ARGS_raspberrypi-cm3 ?= "cma=256M vc_mem.mem_base=0x3ec00000 vc_mem.mem_size=0x40000000 ${OSTREE_KERNEL_ARGS_COMMON_RPI}"
OSTREE_KERNEL_ARGS_raspberrypi4 ?= "video=HDMI-A-1:1280x720@60 cma=256M vc_mem.mem_base=0x3ec00000 vc_mem.mem_size=0x40000000 ${OSTREE_KERNEL_ARGS_COMMON_RPI}"
## U-Boot entrypoints for rpi
UBOOT_ENTRYPOINT_rpi = "0x00008000"
UBOOT_DTB_LOADADDRESS_rpi = "0x02600000"
UBOOT_DTBO_LOADADDRESS_rpi = "0x026d0000"
## RPI: Use official raspberrypi downstream kernel
PREFERRED_PROVIDER_virtual/kernel_rpi ?= "linux-lmp-dev"
LINUX_VERSION_rpi ?= "4.19.y"
KERNEL_REPO_rpi ?= "git://github.com/raspberrypi/linux.git"
KERNEL_BRANCH_rpi ?= "rpi-4.19.y"
KERNEL_COMMIT_rpi ?= "988cc7beacc150756c3fbe40646afcf8438b741b"
KERNEL_META_BRANCH_rpi ?= "linux-v4.19.y"
KERNEL_META_COMMIT_rpi ?= "2e38f45a09730a7816e1c0ec3b01bc5fa434dab9"
MACHINE_FEATURES_append_raspberrypi4 = " armstub"

# RISC-V targets
INITRAMFS_IMAGE_BUNDLE_qemuriscv64 = "1"
KERNEL_INITRAMFS_qemuriscv64 = '-initramfs'
IMAGE_BOOT_FILES_qemuriscv64 = "boot.scr uEnv.txt"
KERNEL_IMAGETYPE_qemuriscv64 = "fitImage"
KERNEL_IMAGETYPES_remove_qemuriscv64 = "uImage"
KERNEL_CLASSES_qemuriscv64 = " kernel-lmp-fitimage "
OSTREE_KERNEL_qemuriscv64 = "${KERNEL_IMAGETYPE}-${INITRAMFS_IMAGE}-${MACHINE}-${MACHINE}"
OSTREE_KERNEL_ARGS_qemuriscv64 ?= "earlycon=sbi ${OSTREE_KERNEL_ARGS_COMMON}"
UBOOT_ENTRYPOINT_qemuriscv64 = "0x80400000"
UBOOT_RD_LOADADDRESS_qemuriscv64 = "0x81000000"
RISCV_SBI_PAYLOAD_qemuriscv64 = "u-boot.bin"
QB_DEFAULT_BIOS_qemuriscv64 = "fw_payload.elf"
QB_DRIVE_TYPE_qemuriscv64 = "/dev/vd"
QB_OPT_APPEND_append_qemuriscv64 = " -bios ${DEPLOY_DIR_IMAGE}/fw_payload.elf"

## Freedom U540
PREFERRED_PROVIDER_virtual/bootloader_freedom-u540 ?= "u-boot"
IMAGE_BOOT_FILES_freedom-u540 = "fw_payload.bin boot.scr uEnv.txt"
OSTREE_KERNEL_freedom-u540 = "${KERNEL_IMAGETYPE}-${INITRAMFS_IMAGE}-${MACHINE}-${MACHINE}"
OSTREE_KERNEL_ARGS_freedom-u540 ?= "earlycon=sbi console=ttySIF0 ${OSTREE_KERNEL_ARGS_COMMON}"
WKS_FILE_freedom-u540_sota = "freedom-u540-opensbi-sota.wks"

# QEMU ARM
PREFERRED_PROVIDER_virtual/bootloader_qemuarm64 = "u-boot-fio"
PREFERRED_PROVIDER_u-boot-fw-utils_qemuarm64 = "u-boot-fio-fw-utils"
PREFERRED_RPROVIDER_u-boot-fw-utils_qemuarm64 = "u-boot-fio-fw-utils"
UBOOT_MACHINE_qemuarm64 = "qemu_arm64_defconfig"
IMAGE_BOOT_FILES_qemuarm64 = "boot.scr uEnv.txt"
KERNEL_IMAGETYPE_qemuarm64 = "fitImage"
KERNEL_CLASSES_qemuarm64 = " kernel-lmp-fitimage "
OSTREE_KERNEL_qemuarm64 = "${KERNEL_IMAGETYPE}-${INITRAMFS_IMAGE}-${MACHINE}-${MACHINE}"
OSTREE_KERNEL_ARGS_qemuarm64 ?= "console=ttyAMA0 ${OSTREE_KERNEL_ARGS_COMMON}"
UBOOT_ENTRYPOINT_qemuarm64 = "0x40080000"
MACHINE_FEATURES_append_qemuarm64 = " optee"
EXTRA_IMAGEDEPENDS_append_qemuarm64 = " atf"
## ARM Trusted Firmware options
TF-A_PLATFORM_qemuarm64 = "qemu"
TF-A_DEPENDS_qemuarm64 = "u-boot"
TF-A_BL33_qemuarm64 = "${DEPLOY_DIR_IMAGE}/u-boot.bin"
TF-A_EXTRA_OPTIONS_qemuarm64 = " BL32=${DEPLOY_DIR_IMAGE}/optee/tee-header_v2.bin \
  BL32_EXTRA1=${DEPLOY_DIR_IMAGE}/optee/tee-pager_v2.bin \
  BL32_EXTRA2=${DEPLOY_DIR_IMAGE}/optee/tee-pageable_v2.bin \
  ARM_TSP_RAM_LOCATION=tdram BL32_RAM_LOCATION=tdram"
QB_MACHINE_qemuarm64 = "-machine virt,secure=on"
## Use same minimal memory amount as suggested by op-tee
QB_MEM_qemuarm64 = "-m 1057"
QB_DRIVE_TYPE_qemuarm64 = "/dev/vd"
## Bios/bl1.bin is ATF, which requires semihosting for the remaining boot artifacts
QB_OPT_APPEND_qemuarm64 = "-no-acpi -bios bl1.bin -d unimp -semihosting-config enable,target=native"

# Intel
OSTREE_BOOTLOADER_intel-corei7-64 ?= "grub"
OSTREE_KERNEL_ARGS_intel-corei7-64 ?= "console=ttyS0,115200 ${OSTREE_KERNEL_ARGS_COMMON}"
EFI_PROVIDER_intel-corei7-64 = "grub-efi"
WKS_FILE_intel-corei7-64_sota = "efidisk-sota.wks"
IMAGE_BOOT_FILES_intel-corei7-64 = ""
IMAGE_FSTYPES_remove_intel-corei7-64 = "live hddimg"

# Common for iMX targets
OSTREE_KERNEL_ARGS_mx6 ?= "console=tty1 console=ttymxc0,115200 ${OSTREE_KERNEL_ARGS_COMMON}"
OSTREE_KERNEL_ARGS_mx7d ?= "console=tty1 console=ttymxc0,115200 ${OSTREE_KERNEL_ARGS_COMMON}"
OSTREE_KERNEL_ARGS_mx7ulp ?= "console=tty1 console=ttyLP0,115200 ${OSTREE_KERNEL_ARGS_COMMON}"

# Toradex Colibri iMX7 (support both NAND and eMMC targets with one single image)
EXTRA_IMAGEDEPENDS_append_colibri-imx7 = " u-boot-script-toradex"
IMAGE_BOOT_FILES_colibri-imx7 = "boot.scr uEnv.txt u-boot-colibri-imx7.imx;u-boot-nand.imx u-boot-colibri-imx7.imx-sd;u-boot-emmc.imx ${MACHINE_ARCH}/*;${MACHINE_ARCH}"
KERNEL_IMAGETYPE_colibri-imx7 = "fitImage"
KERNEL_CLASSES_colibri-imx7 = " kernel-lmp-fitimage "
OSTREE_KERNEL_colibri-imx7 = "${KERNEL_IMAGETYPE}-${INITRAMFS_IMAGE}-${MACHINE}-${MACHINE}"
UBOOT_DTB_LOADADDRESS_colibri-imx7 = "0x82000000"
UBOOT_RD_LOADADDRESS_colibri-imx7 = "0x82100000"

# Toradex Apalis iMX6
EXTRA_IMAGEDEPENDS_append_apalis-imx6 = " u-boot-script-toradex"
IMAGE_BOOT_FILES_apalis-imx6 = "boot.scr uEnv.txt SPL u-boot.imx-spl ${MACHINE_ARCH}/flash_blk.img;flash_blk.img"
KERNEL_IMAGETYPE_apalis-imx6 = "fitImage"
KERNEL_CLASSES_apalis-imx6 = " kernel-lmp-fitimage "
OSTREE_KERNEL_apalis-imx6 = "${KERNEL_IMAGETYPE}-${INITRAMFS_IMAGE}-${MACHINE}-${MACHINE}"
PREFERRED_PROVIDER_virtual/bootloader_apalis-imx6 = "u-boot-fio"
PREFERRED_PROVIDER_u-boot_apalis-imx6 = "u-boot-fio"
PREFERRED_PROVIDER_u-boot-fw-utils_apalis-imx6 = "u-boot-fio-fw-utils"
PREFERRED_RPROVIDER_u-boot-fw-utils_apalis-imx6 = "u-boot-fio-fw-utils"
UBOOT_DTB_LOADADDRESS_apalis-imx6 = "0x12f00000"
UBOOT_RD_LOADADDRESS_apalis-imx6 = "0x13000000"

# iMX8MM
PREFERRED_PROVIDER_u-boot-fw-utils_mx8mm = "u-boot-imx-fw-utils"
PREFERRED_RPROVIDER_u-boot-fw-utils_mx8mm = "u-boot-imx-fw-utils"
SOTA_CLIENT_FEATURES_append_mx8mm = " ubootenv"
UBOOT_DTB_LOADADDRESS_mx8mm = "0x43000000"
IMAGE_BOOT_FILES_mx8mm = "boot.scr uEnv.txt imx-boot"
KERNEL_IMAGETYPE_mx8mm = "fitImage"
KERNEL_CLASSES_mx8mm = " kernel-lmp-fitimage "
KERNEL_DEVICETREE_mx8mm ?= "freescale/fsl-imx8mm-evk.dtb freescale/fsl-imx8mm-ddr4-evk.dtb"
OSTREE_KERNEL_mx8mm = "${KERNEL_IMAGETYPE}-${INITRAMFS_IMAGE}-${MACHINE}-${MACHINE}"
OSTREE_KERNEL_ARGS_mx8mm ?= "console=tty1 console=ttymxc1,115200 earlycon=ec_imx6q,0x30890000,115200 root=/dev/mmcblk2p2 rootfstype=ext4"
## iMX8: Use latest NXP BSP downstream kernel
PREFERRED_PROVIDER_virtual/kernel_mx8mm ?= "linux-lmp-dev"
LINUX_VERSION_mx8mm ?= "4.19.y"
KERNEL_REPO_mx8mm ?= "git://source.codeaurora.org/external/imx/linux-imx"
KERNEL_BRANCH_mx8mm ?= "imx_4.19.35_1.1.0"
KERNEL_COMMIT_mx8mm ?= "0f9917c56d5995e1dc3bde5658e2d7bc865464de"
KERNEL_META_BRANCH_mx8mm ?= "linux-v4.19.y"
KERNEL_META_COMMIT_mx8mm ?= "45e0627e7e7f5692e9311aa3608d965f59a44f61"
MACHINE_FIRMWARE_mx8mm = "linux-firmware-imx-sdma-imx7d"
WKS_FILE_mx8mm_sota = "sdimage-imx8-sota.wks.in"
## iMX8MM EVK
PREFERRED_VERSION_optee-os_imx8mmevk = "3.6.0+git"
PREFERRED_VERSION_optee-client_imx8mmevk = "3.6.0+git"
PREFERRED_VERSION_optee-test_imx8mmevk = "3.6.0"
MACHINE_FEATURES_remove_imx8mmevk = "qca9377 qca6174"

# Cross machines / BSPs
## No need to install u-boot, already a WKS dependency
MACHINE_ESSENTIAL_EXTRA_RDEPENDS_remove_imx = "u-boot-fslc"
