FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_rpi = " \
        file://overlays_rpi-7inch.dts \
        file://overlays_rpi-7inch-flip.dts \
"
COMPATIBLE_MACHINE_rpi = ".*"
