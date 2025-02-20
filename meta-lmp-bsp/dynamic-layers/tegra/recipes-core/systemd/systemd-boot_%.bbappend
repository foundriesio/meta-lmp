FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:orin-nano = " file://0001-Increase-the-dtb-size.patch"
