# We need to extend files paths because the -rt version of this
# recipe includes this one and we need to have patches for this
# recipe available in -rt recipe.
# Extend files paths with the short kernel version to be able to keep
# different patches with the same names for different kernel versions.
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}/${KSHORT_VER}:${THISDIR}/${PN}:"

KERNEL_DEVICETREE_32BIT_COMPATIBILITY_UPDATE = "1"

include recipes-kernel/linux/linux-lmp-fslc-imx.inc

include recipes-kernel/linux/kmeta-linux-lmp-6.1.y.inc

# Use Freescale kernel by default
LINUX_VERSION ?= "6.1.70"
KERNEL_BRANCH ?= "6.1-2.2.x-imx"
SRCREV_machine = "4e3fc5471376a15279ee5c99e791a7c7b065cbc1"

SRC_URI += " \
    file://0001-FIO-extras-arm64-dts-imx8mm-evk-use-imx8mm-evkb-for-.patch \
"
