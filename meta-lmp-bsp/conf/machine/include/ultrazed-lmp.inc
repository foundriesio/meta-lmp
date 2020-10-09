# Avnet UltraZed Generic Settings

MACHINEOVERRIDES = "uz:uz3eg:${MACHINE}"

XILINX_VER_MAIN ?= "2020.1"

PREFERRED_PROVIDER_virtual/kernel_uz ?= "linux-lmp-xlnx"

require conf/machine/include/soc-zynqmp.inc
require conf/machine/include/machine-xilinx-default.inc

MACHINE_FEATURES = "rtc ext2 ext3 vfat usbhost optee"

EXTRA_IMAGEDEPENDS += "libyaml-native python3-cython-native python3-pyyaml-native"

PREFERRED_PROVIDER_u-boot-fw-utils = "libubootenv"
PREFERRED_RPROVIDER_u-boot-fw-utils = "libubootenv"
SOTA_CLIENT_FEATURES_append = " ubootenv"
WKS_FILE_DEPENDS_append = " u-boot-default-script"
PREFERRED_PROVIDER_u-boot-default-script = "u-boot-base-scr"
PREFERRED_PROVIDER_u-boot-default-script_sota = "u-boot-ostree-scr-fit"

PREFERRED_VERSION_optee-os-fio = "3.10.0+git"
PREFERRED_VERSION_optee-client = "3.10.0"
PREFERRED_VERSION_optee-examples = "3.10.0"
PREFERRED_VERSION_optee-test = "3.10.0"
OPTEE_BINARY = "tee-pager_v2.bin"

SPL_BINARY ?= "spl/boot.bin"
UBOOT_MACHINE ?= "xilinx_zynqmp_virt_defconfig"
UBOOT_CLASSES = "uboot-fitimage"
UBOOTFDT_LOADADDRESS = "0x00100000"
UBOOT_ENTRYPOINT  = "0x00080000"
UBOOT_DTB_LOADADDRESS = "0x1f000000"
UBOOT_RD_LOADADDRESS = "0x20000000"

ATF_BINARY = "arm-trusted-firmware.bin"
ATF_MEM_BASE = "0xfffe5000"
ATF_MEM_SIZE = "0x1affe"

SERIAL_CONSOLES ?= "115200;ttyPS0"

KERNEL_IMAGETYPE_sota = "fitImage"
KERNEL_CLASSES_sota = " kernel-lmp-fitimage "
OSTREE_KERNEL_ARGS ?= "console=ttyPS0,115200 ${OSTREE_KERNEL_ARGS_COMMON}"
PREFERRED_PROVIDER_virtual/dtb ?= "device-tree"
PREFERRED_PROVIDER_virtual/trusted-firmware-a ?= "arm-trusted-firmware"

EXTRA_IMAGEDEPENDS += " \
    virtual/bootloader \
    virtual/pmu-firmware \
    virtual/trusted-firmware-a \
"

# Used to create a wic image to boot from emmc
IMAGE_BOOT_FILES_append = " boot.bin"
IMAGE_BOOT_FILES_sota = " u-boot.itb boot.itb"

PMU_FIRMWARE_IMAGE_NAME ?= "pmu-firmware-${MACHINE}"
PMU_FIRMWARE_DEPLOY_DIR ?= "${DEPLOY_DIR_IMAGE}"

# Not building for QEMU standard Xinix build
EXTRA_IMAGEDEPENDS_remove = "qemu-devicetrees"
