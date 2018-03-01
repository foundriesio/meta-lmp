require recipes-bsp/u-boot/u-boot.inc

DESCRIPTION = "u-boot which includes support for CompuLab boards."
LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://Licenses/README;md5=a2c678cfd4a4d97135585cad908541c6"

SECTION = "bootloader"
PROVIDES += "u-boot"

SRCBRANCH = "master"
SRCREV = "v2017.07"
SRC_URI = "git://git.denx.de/u-boot.git;branch=${SRCBRANCH} \
	file://u-boot-v2017.07-cl-som-imx7-1.1.patch \
	file://enable_distro_defaults.patch \
	file://standard_boot_env.patch \
	file://enable_importenv.patch \
"

S = "${WORKDIR}/git"

PACKAGE_ARCH = "${MACHINE_ARCH}"
COMPATIBLE_MACHINE = "(cl-som-imx7)"
