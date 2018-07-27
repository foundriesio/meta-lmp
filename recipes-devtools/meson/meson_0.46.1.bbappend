FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " \
    file://0001-Add-riscv32-and-riscv64-targets.patch \
"
