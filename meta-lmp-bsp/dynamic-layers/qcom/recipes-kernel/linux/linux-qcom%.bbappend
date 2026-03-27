FILESEXTRAPATHS:prepend := "${THISDIR}/../../../../recipes-kernel/linux/files:"

SRC_URI:append:lmp = " file://lmp.cfg"
