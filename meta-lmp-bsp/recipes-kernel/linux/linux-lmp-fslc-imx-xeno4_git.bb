FILESEXTRAPATHS:prepend := "${THISDIR}/linux-lmp-fslc-imx:"

include linux-lmp-fslc-imx_git.bb

KERNEL_REPO = "git://github.com/foundriesio/linux.git"
LINUX_VERSION = "5.15.87"
KERNEL_BRANCH = "5.15-2.2.x-imx-xeno4"

SRCREV_machine = "dbd918d3a96e088088307b4a62886efd889058a6"
LINUX_KERNEL_TYPE = "xeno4"
