FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append += " \
    file://Move-default-sota-config-from-usr-lib-to-var.patch \
"
