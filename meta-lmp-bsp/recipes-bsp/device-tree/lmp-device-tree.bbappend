FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_rpi = " \
        file://overlays_rpi-7inch.dts \
        file://overlays_rpi-7inch-flip.dts \
        file://overlays_i2c1.dts \
        file://overlays_spi0.dts \
"
COMPATIBLE_MACHINE_rpi = ".*"
