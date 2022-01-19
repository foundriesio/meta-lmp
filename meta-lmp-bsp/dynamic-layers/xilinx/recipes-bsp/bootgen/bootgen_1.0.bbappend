FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
    file://0001-zynqmp-bootloader-support-binary-format.patch \
"
