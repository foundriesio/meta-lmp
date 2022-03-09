# Based on xilinx-board.inc, but with correct MACHINEOVERRIDES settings
BOARD ??= ""
BOARD_VARIANT ??= ""
BOARD_ARCH ?= "${@['${BOARD}', '${MACHINE_ARCH}'][d.getVar('BOARD')=='']}"
BOARDVARIANT_ARCH ?= "${@['${BOARD}-${BOARD_VARIANT}','${BOARD_ARCH}'][d.getVar('BOARD_VARIANT')=='']}"
MACHINEOVERRIDES =. "${@['', '${BOARD}-${BOARD_VARIANT}:']['${BOARD_VARIANT}' != '']}"
MACHINEOVERRIDES =. "${@['', '${BOARD}:']['${BOARD}' != '']}"
PACKAGE_EXTRA_ARCHS:append = "${@['', ' ${BOARD_ARCH}'][d.getVar('BOARDVARIANT_ARCH') != d.getVar('MACHINE_ARCH')]}"
PACKAGE_EXTRA_ARCHS:append = "${@['', ' ${BOARDVARIANT_ARCH}'][d.getVar('BOARDVARIANT_ARCH') != d.getVar('BOARD_ARCH')]}"

XILINX_VER_MAIN ?= "2021.2"

PREFERRED_PROVIDER_virtual/kernel:zynqmp ?= "linux-lmp-xlnx"

require conf/machine/include/soc-zynqmp.inc
require conf/machine/include/machine-xilinx-default.inc

MACHINE_FEATURES = "rtc ext2 ext3 vfat usbhost usbgadget wifi bluetooth optee"

EXTRA_IMAGEDEPENDS += "libyaml-native python3-cython-native python3-pyyaml-native"

PREFERRED_PROVIDER_virtual/bitstream ?= "bitstream-extraction"

PREFERRED_PROVIDER_u-boot = "u-boot-xlnx"
PREFERRED_PROVIDER_virtual/boot-bin ?= "u-boot-xlnx"
PREFERRED_PROVIDER_u-boot-fw-utils = "libubootenv"
PREFERRED_RPROVIDER_u-boot-fw-utils = "libubootenv"
SOTA_CLIENT_FEATURES:append = " ubootenv"
WKS_FILE_DEPENDS:append = " u-boot-default-script"
PREFERRED_PROVIDER_u-boot-default-script = "u-boot-base-scr"
PREFERRED_PROVIDER_u-boot-default-script:sota ?= "u-boot-ostree-scr-fit"

SPL_BINARY ?= "spl/boot.bin"
UBOOT_MACHINE ?= "xilinx_zynqmp_virt_defconfig"
UBOOT_CLASSES = "uboot-fitimage"
UBOOT_ENTRYPOINT  = "0x18000000"
UBOOT_DTB_LOADADDRESS = "0x40000000"

EFI_PROVIDER ?= "${@bb.utils.contains('MACHINE_FEATURES', 'ebbr', 'grub-efi', '', d)}"

ATF_BINARY = "arm-trusted-firmware.bin"
ATF_MEM_BASE = "0xfffe5000"
ATF_MEM_SIZE = "0x1affe"

SERIAL_CONSOLES ?= "115200;ttyPS0"

OSTREE_BOOTLOADER ?= "${@bb.utils.contains('MACHINE_FEATURES', 'ebbr', 'grub', 'u-boot', d)}"
KERNEL_IMAGETYPE:sota ?= "${@bb.utils.contains('MACHINE_FEATURES', 'ebbr', 'Image', 'fitImage', d)}"
KERNEL_CLASSES:sota ?= "${@bb.utils.contains('MACHINE_FEATURES', 'ebbr', '', ' kernel-lmp-fitimage ', d)}"
OSTREE_KERNEL_ARGS ?= "console=ttyPS0,115200 ${OSTREE_KERNEL_ARGS_COMMON}"
PREFERRED_PROVIDER_virtual/dtb ?= "device-tree"
PREFERRED_PROVIDER_virtual/trusted-firmware-a ?= "arm-trusted-firmware"

EXTRA_IMAGEDEPENDS += " \
    virtual/bitstream \
    virtual/bootloader \
    virtual/pmu-firmware \
    virtual/boot-bin \
    virtual/trusted-firmware-a \
    ${@bb.utils.contains('OSTREE_BOOTLOADER', 'grub', 'grub-efi', '', d)} \
"

# Used to create a wic image to boot from emmc
WKS_FILE = "sdimage-bootpart.wks"
WKS_FILE:sota = "${@bb.utils.contains('MACHINE_FEATURES', 'ebbr', 'sdimage-mbr-efi-sota.wks', 'sdimage-sota.wks', d)}"
WKS_FILE_DEPENDS:append = " virtual/bootloader"
IMAGE_BOOT_FILES = "${@get_default_image_boot_files(d)} boot.bin boot.scr uEnv.txt devicetree/system-top.dtb;system-top.dtb bitstream.bit.bin"
IMAGE_BOOT_FILES:sota = "boot.bin;boot0001.bin u-boot.itb;u-boot0001.itb boot.bin;boot0002.bin u-boot.itb;u-boot0002.itb"
IMAGE_BOOT_FILES:sota:append = " ${@bb.utils.contains('MACHINE_FEATURES', 'ebbr', 'devicetree/system-top.dtb;system-top.dtb', '', d)}"

# Boot firmware updates
LMP_BOOT_FIRMWARE_FILES:sota = "boot.bin u-boot.itb"
BOOTSCR_LOAD_ADDR:sota = "0x21000000"

# Not building for QEMU standard Xinix build
EXTRA_IMAGEDEPENDS:remove = "qemu-devicetrees"
