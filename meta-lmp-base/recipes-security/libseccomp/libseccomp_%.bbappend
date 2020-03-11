FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append = " \
    file://0001-arch-Add-RISC-V-64-bit-support.patch \
"
