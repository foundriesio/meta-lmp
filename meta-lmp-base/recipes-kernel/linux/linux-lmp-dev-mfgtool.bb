SUMMARY = "Produces a Manufacturing Tool compatible Linux Kernel"
DESCRIPTION = "Linux Kernel recipe that produces a Manufacturing Tool \
compatible Linux Kernel to be used in updater environment"

# Use Freescale kernel by default
KERNEL_REPO ?= "git://github.com/Freescale/linux-fslc.git"
KERNEL_REPO_PROTOCOL ?= "https"
LINUX_VERSION ?= "5.10.80"
KERNEL_BRANCH ?= "5.10-2.1.x-imx"

# Drop features that are appended by other layers (not required here)
KERNEL_FEATURES_remove = "cfg/fs/vfat.scc"

require recipes-kernel/linux/linux-lmp-dev.bb

# lzop is commonly used by mfgtool-based kernel
DEPENDS += "lzop-native"

SRC_URI = "${KERNEL_REPO};protocol=${KERNEL_REPO_PROTOCOL};branch=${KERNEL_BRANCH};name=machine;"
KMETA = ""
