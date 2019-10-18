SUMMARY = "Linux microPlatform BSP device trees"
DESCRIPTION = "Linux microPlatform BSP device trees available from within layer"
SECTION = "bsp"

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0;md5=801f80980d171dd6425610833a22dbe6"

inherit devicetree

PROVIDES = "virtual/dtb"

# device tree overlays
SRC_URI_append_rpi = " \
	file://overlays_rpi-7inch.dts \
	file://overlays_rpi-7inch-flip.dts \
"
COMPATIBLE_MACHINE_rpi = ".*"
