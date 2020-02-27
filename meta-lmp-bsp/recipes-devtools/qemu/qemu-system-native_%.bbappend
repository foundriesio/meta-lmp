FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " \
    file://0001-target-arm-arm-semi-fix-SYS_OPEN-to-return-nonzero-f.patch \
"
