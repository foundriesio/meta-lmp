FILESEXTRAPATHS:prepend := "${THISDIR}/linux-lmp-fslc-imx:${THISDIR}/linux-lmp-fslc-imx/5.15:"

include linux-lmp-fslc-imx_5.15_git.bb

KERNEL_REPO = "git://github.com/foundriesio/linux.git"
LINUX_VERSION = "5.15.76"
KERNEL_BRANCH = "5.15-2.1.x-imx-rt"

SRCREV_machine = "97c1a3ca78e9543bdb5da6d793d19c3157870a0a"
LINUX_KERNEL_TYPE = "preempt-rt"
