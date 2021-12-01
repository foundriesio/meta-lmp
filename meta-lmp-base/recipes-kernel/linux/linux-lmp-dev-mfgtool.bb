SUMMARY = "Produces a Manufacturing Tool compatible Linux Kernel"
DESCRIPTION = "Linux Kernel recipe that produces a Manufacturing Tool \
compatible Linux Kernel to be used in updater environment"

# Use NXP BSP by default
KERNEL_REPO ?= "git://source.codeaurora.org/external/imx/linux-imx.git"
KERNEL_REPO_PROTOCOL ?= "https"
LINUX_VERSION ?= "5.10.35"
KERNEL_BRANCH ?= "lf-5.10.y"

# Drop features that are appended by other layers (not required here)
KERNEL_FEATURES_remove = "cfg/fs/vfat.scc"

require recipes-kernel/linux/linux-lmp-dev.bb

# lzop is commonly used by mfgtool-based kernel
DEPENDS += "lzop-native"

SRC_URI = "${KERNEL_REPO};protocol=${KERNEL_REPO_PROTOCOL};branch=${KERNEL_BRANCH};name=machine;"
KMETA = ""
