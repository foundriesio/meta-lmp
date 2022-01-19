FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:rpi = " \
        file://overlays_rpi-7inch.dts \
        file://overlays_rpi-7inch-flip.dts \
        file://overlays_i2c1.dts \
        file://overlays_spi0.dts \
"
COMPATIBLE_MACHINE:rpi = ".*"

# Name compatible with 4.19-based BSP
SRC_URI:append:imx8mm-lpddr4-evk = " \
        file://freescale_fsl-imx8mm-evk.dts \
"
COMPATIBLE_MACHINE:imx8mm-lpddr4-evk = ".*"
