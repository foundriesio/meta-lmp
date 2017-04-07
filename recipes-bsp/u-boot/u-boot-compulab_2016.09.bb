require recipes-bsp/u-boot/u-boot.inc

DESCRIPTION = "u-boot which includes support for CompuLab boards."
LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://Licenses/README;md5=a2c678cfd4a4d97135585cad908541c6"

SECTION = "bootloader"
PROVIDES = "u-boot"

SRCBRANCH = "master"
SRCREV = "v2016.09"
SRC_URI = "git://git.denx.de/u-boot.git;branch=${SRCBRANCH}"
#SRC_URI[md5sum] = "fd8234c5b3a460430689848c1f16acef"

include u-boot-compulab_cl-som-imx7.inc

S = "${WORKDIR}/git"

#do_compile_append () {
#	oe_runmake u-boot.imx
#}

PACKAGE_ARCH = "${MACHINE_ARCH}"
COMPATIBLE_MACHINE = "(cl-som-imx7)"
