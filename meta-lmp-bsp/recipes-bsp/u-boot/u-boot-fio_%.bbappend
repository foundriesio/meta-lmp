FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_cubox-i += " \
    file://0001-mx6cuboxi-only-check-for-eMMC-if-som-is-at-least-1.5.patch \
    file://0001-mx6cuboxi-enable-FIT.patch \
"
