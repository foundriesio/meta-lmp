FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

RDEPENDS_${PN}_append_sota = " u-boot-ostree-scr"

SRC_URI_append += " \
    file://0001-colibri_imx7-run-distro_bootcmd-by-default.patch \
    file://0001-colibri_imx7-prefer-non-secure-mode-by-default.patch \
    file://0001-libfdt-remove-leading-underscore-from-identifiers.patch \
"
