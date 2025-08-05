include linux-lmp-fslc-imx_${PV}.bb

# This should be after including non-RT recipe to override patches
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

LINUX_VERSION = "6.6.36"
KERNEL_BRANCH = "linux_6.6.36"

KERNEL_REPO = "git://github.com/nxp-real-time-edge-sw/real-time-edge-linux.git"
SRCREV_machine = "f03af81d60b7ae14e03fafa8f4c4289c30a73f93"
LINUX_KERNEL_TYPE = "preempt-rt"
