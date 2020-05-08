FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_rpi = " \
        file://overlays_rpi-7inch.dts \
        file://overlays_rpi-7inch-flip.dts \
        file://overlays_i2c1.dts \
        file://overlays_spi0.dts \
"
COMPATIBLE_MACHINE_rpi = ".*"

# Name compatible with 4.19-based BSP
SRC_URI_append_imx8mmevk = " \
        file://freescale_fsl-imx8mm-evk.dts \
"
COMPATIBLE_MACHINE_imx8mmevk = ".*"
