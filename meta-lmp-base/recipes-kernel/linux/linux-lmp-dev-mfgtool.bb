SUMMARY = "Produces a Manufacturing Tool compatible Linux Kernel"
DESCRIPTION = "Linux Kernel recipe that produces a Manufacturing Tool \
compatible Linux Kernel to be used in updater environment"

# From kernel 5.4.y
LIC_FILES_CHKSUM ?= "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"

require recipes-kernel/linux/linux-lmp-dev.bb

# lzop is commonly used by mfgtool-based kernel
DEPENDS += "lzop-native"

SRC_URI = "${KERNEL_REPO};branch=${KERNEL_BRANCH};name=machine;"
KMETA = ""
