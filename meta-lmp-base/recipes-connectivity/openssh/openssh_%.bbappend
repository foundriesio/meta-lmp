FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# OE-Core sets to rng-tools by default, which is not wanted by meta-lmp,
# unless the BSP has a kernel < 5.6 (which can be added in meta-lmp-bsp).
PACKAGECONFIG ?= ""
