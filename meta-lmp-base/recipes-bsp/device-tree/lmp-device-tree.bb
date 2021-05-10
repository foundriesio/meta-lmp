SUMMARY = "Linux microPlatform BSP device trees"
DESCRIPTION = "Linux microPlatform BSP device trees available from within layer"
SECTION = "bsp"

LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-2.0-only;md5=801f80980d171dd6425610833a22dbe6"

inherit devicetree

PROVIDES = "virtual/dtb"

# Device tree and overlays to be provided by the BSP layer
# E.g.:
# SRC_URI_append_board = "file://overlays_board.dts"
# COMPATIBLE_MACHINE_board = ".*"
