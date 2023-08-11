include linux-lmp-fslc-imx_${PV}.bb

# This should be after including non-RT recipe to override patches
FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

LINUX_VERSION = "6.1.38"
KERNEL_BRANCH = "6.1-2.0.x-imx-rt"

KERNEL_REPO = "git://github.com/foundriesio/linux.git"
SRCREV_machine = "7741431d45f6e8930367998a4ca3e16f93d758fb"
LINUX_KERNEL_TYPE = "preempt-rt"
