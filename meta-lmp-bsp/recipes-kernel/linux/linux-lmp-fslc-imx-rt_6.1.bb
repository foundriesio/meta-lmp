FILESEXTRAPATHS:prepend := "${THISDIR}/linux-lmp-fslc-imx:"

include linux-lmp-fslc-imx_${PV}.bb

KERNEL_REPO = "git://github.com/foundriesio/linux.git"
LINUX_VERSION = "6.1.26"
KERNEL_BRANCH = "6.1-1.0.x-imx-rt"

SRCREV_machine = "b0d53b2f48c3626b7df546617f87fc8bf70232de"
LINUX_KERNEL_TYPE = "preempt-rt"
