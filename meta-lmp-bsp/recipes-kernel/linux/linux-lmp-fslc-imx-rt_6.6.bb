include linux-lmp-fslc-imx_${PV}.bb

# This should be after including non-RT recipe to override patches
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

LINUX_VERSION = "6.6.36"
KERNEL_BRANCH = "linux_6.6.36"

KERNEL_REPO = "git://github.com/nxp-real-time-edge-sw/real-time-edge-linux.git"
SRCREV_machine = "e7369ce0b24dbacba728e7f7ee29016d4759a7ce"
LINUX_KERNEL_TYPE = "preempt-rt"
