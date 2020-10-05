FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# RPI: 7-Inch display support
SRC_URI_append_rpi = " \
    file://0001-FIO-extras-drm-panel-rpi-add-lcd-rotate-property.patch \
"
