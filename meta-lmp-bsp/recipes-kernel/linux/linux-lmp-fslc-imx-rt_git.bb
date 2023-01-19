FILESEXTRAPATHS:prepend := "${THISDIR}/linux-lmp-fslc-imx:"

include linux-lmp-fslc-imx_git.bb

KERNEL_REPO = "git://github.com/foundriesio/linux.git"
LINUX_VERSION = "5.15.87"
KERNEL_BRANCH = "5.15-2.2.x-imx-rt"

SRCREV_machine = "fcaf9383fa6e53c4db91dd296c409028ba026a4c"
LINUX_KERNEL_TYPE = "preempt-rt"
