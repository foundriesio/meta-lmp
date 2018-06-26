FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " \
    file://0001-Fix-for-teec_trace.c-snprintf-Werror-format-truncati.patch \
"
