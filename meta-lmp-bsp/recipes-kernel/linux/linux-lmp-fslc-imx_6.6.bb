# We need to extend files paths because the -rt version of this
# recipe includes this one and we need to have patches for this
# recipe available in -rt recipe.
# Extend files paths with the short kernel version to be able to keep
# different patches with the same names for different kernel versions.
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}/${KSHORT_VER}:${THISDIR}/${PN}:"

include recipes-kernel/linux/linux-lmp-fslc-imx.inc

include recipes-kernel/linux/kmeta-linux-lmp-6.6.y.inc

# Use Freescale kernel by default
LINUX_VERSION ?= "6.6.28"
KERNEL_BRANCH ?= "6.6-1.0.x-imx"

SRCREV_machine = "776652a165f5bbf30c68a5f6213d75b02e8df11c"

DEFAULT_PREFERENCE = "-1"
