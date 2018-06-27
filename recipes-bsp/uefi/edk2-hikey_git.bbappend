FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " \
    file://0001-BaseTools-tools_def-add-fno-unwind-tables-to-GCC_AAR.patch \
"
