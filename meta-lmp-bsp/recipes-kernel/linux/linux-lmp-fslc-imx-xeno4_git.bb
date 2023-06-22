FILESEXTRAPATHS:prepend := "${THISDIR}/linux-lmp-fslc-imx:"

include linux-lmp-fslc-imx_6.1.bb

KERNEL_REPO = "git://github.com/foundriesio/linux.git"
LINUX_VERSION = "6.1.24"
KERNEL_BRANCH = "6.1-1.0.x-imx-xeno4"

SRCREV_machine = "25aa4b67c7364c4e628b0ce2e12429b287937b76"
LINUX_KERNEL_TYPE = "xeno4"
