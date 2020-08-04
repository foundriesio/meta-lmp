SUMMARY = "Produces a Manufacturing Tool compatible Linux Kernel"
DESCRIPTION = "Linux Kernel recipe that produces a Manufacturing Tool \
compatible Linux Kernel to be used in updater environment"

require recipes-kernel/linux/linux-lmp-dev.bb

# lzop is commonly used by mfgtool-based kernel
DEPENDS += "lzop-native"

SRC_URI = "${KERNEL_REPO};branch=${KERNEL_BRANCH};name=machine;"
KMETA = ""
