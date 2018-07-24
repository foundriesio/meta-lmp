require recipes-bsp/u-boot/u-boot.inc

DESCRIPTION = "u-boot which includes support for CompuLab boards."
LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://Licenses/README;md5=a2c678cfd4a4d97135585cad908541c6"

SECTION = "bootloader"
PROVIDES += "u-boot"

SRCBRANCH = "master"
SRCREV = "v2017.07"
SRC_URI = "git://git.denx.de/u-boot.git;branch=${SRCBRANCH} \
	file://0001-net-Use-packed-structures-for-networking.patch \
	file://u-boot-2017.07-cl-som-imx7-1.5.patch \
	file://enable_distro_defaults.patch \
	file://standard_boot_env.patch \
"

S = "${WORKDIR}/git"

PACKAGE_ARCH = "${MACHINE_ARCH}"
COMPATIBLE_MACHINE = "(cl-som-imx7)"

# SOTA specific
RDEPENDS_${PN}_append_sota = " u-boot-ostree-scr"
