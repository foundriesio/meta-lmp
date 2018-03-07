FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append += " \
    file://0001-colibri_imx7-run-distro_bootcmd-by-default.patch \
"
