FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " \
    file://0001-zynqmp-bootloader-support-binary-format.patch \
"
