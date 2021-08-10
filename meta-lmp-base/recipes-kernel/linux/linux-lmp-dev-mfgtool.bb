SUMMARY = "Produces a Manufacturing Tool compatible Linux Kernel"
DESCRIPTION = "Linux Kernel recipe that produces a Manufacturing Tool \
compatible Linux Kernel to be used in updater environment"

# From kernel 5.4.y
LIC_FILES_CHKSUM ?= "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"

# Use NXP BSP by default
KERNEL_REPO ?= "git://source.codeaurora.org/external/imx/linux-imx.git"
LINUX_VERSION ?= "5.4.y"
KERNEL_BRANCH ?= "imx_5.4.70_2.3.0"

# Drop features that are appended by other layers (not required here)
KERNEL_FEATURES_remove = "cfg/fs/vfat.scc"

require recipes-kernel/linux/linux-lmp-dev.bb

# lzop is commonly used by mfgtool-based kernel
DEPENDS += "lzop-native"

SRC_URI = "${KERNEL_REPO};branch=${KERNEL_BRANCH};name=machine;"
KMETA = ""
