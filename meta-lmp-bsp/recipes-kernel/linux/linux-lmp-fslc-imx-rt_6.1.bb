FILESEXTRAPATHS:prepend := "${THISDIR}/linux-lmp-fslc-imx:"

include linux-lmp-fslc-imx_${PV}.bb

KERNEL_REPO = "git://github.com/foundriesio/linux.git"
LINUX_VERSION = "6.1.38"
KERNEL_BRANCH = "6.1-2.0.x-imx-rt"

SRCREV_machine = "c2ea24ccb87b8fd6dc075e784eb00d229e320b85"
LINUX_KERNEL_TYPE = "preempt-rt"
