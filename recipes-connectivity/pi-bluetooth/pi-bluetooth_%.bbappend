FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_raspberrypi3 = " \
    file://0001-btuart-force-noflow-by-default.patch \
"

SRC_URI_append_raspberrypi4 = " \
    file://0001-btuart-don-t-set-bdaddr-on-rpi-4.patch \
"
