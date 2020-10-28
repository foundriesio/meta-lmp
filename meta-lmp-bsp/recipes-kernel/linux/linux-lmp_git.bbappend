FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_corstone700 = " \
    file://defconfig \
"
