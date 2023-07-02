SUMMARY = "Produces a Manufacturing Tool compatible Linux Kernel"
DESCRIPTION = "Linux Kernel recipe that produces a Manufacturing Tool \
compatible Linux Kernel to be used in updater environment"

# Use Freescale kernel by default
KERNEL_REPO ?= "git://github.com/Freescale/linux-fslc.git"
KERNEL_REPO_PROTOCOL ?= "https"
LINUX_VERSION ?= "6.1.24"
KERNEL_BRANCH ?= "6.1-1.0.x-imx"
KERNEL_COMMIT ?= "3260d1af47b1bedfe12b79a26efa184b9a60a8a3"

# Drop features that are appended by other layers (not required here)
KERNEL_FEATURES:remove = "cfg/fs/vfat.scc"

require recipes-kernel/linux/linux-lmp-dev.bb

# lzop is commonly used by mfgtool-based kernel
DEPENDS += "lzop-native"

SRC_URI = "${KERNEL_REPO};protocol=${KERNEL_REPO_PROTOCOL};branch=${KERNEL_BRANCH};name=machine;"
KMETA = ""

KBUILD_DEFCONFIG:mx6-generic-bsp = "imx_v7_defconfig"
KBUILD_DEFCONFIG:mx7-generic-bsp = "imx_v7_defconfig"
KBUILD_DEFCONFIG:mx8-generic-bsp = "imx_v8_defconfig"
KBUILD_DEFCONFIG:mx9-generic-bsp = "imx_v8_defconfig"
