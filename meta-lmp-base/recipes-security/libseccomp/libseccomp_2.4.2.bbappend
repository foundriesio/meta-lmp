FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " \
    file://0001-api-define-__SNR_ppoll-again.patch \
    file://0001-arch-Add-RISC-V-64-bit-support.patch \
"
