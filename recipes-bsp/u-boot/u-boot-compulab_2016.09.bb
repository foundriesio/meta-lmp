require recipes-bsp/u-boot/u-boot.inc

DESCRIPTION = "u-boot which includes support for CompuLab boards."
LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://Licenses/README;md5=a2c678cfd4a4d97135585cad908541c6"

SECTION = "bootloader"
PROVIDES += "u-boot"

SRCBRANCH = "master"
SRCREV = "v2016.09"
SRC_URI = "git://git.denx.de/u-boot.git;branch=${SRCBRANCH}"
SRC_URI[md5sum] = "fd8234c5b3a460430689848c1f16acef"

S = "${WORKDIR}/git"

SRC_URI_append_cl-som-imx7 += "file://cl_som_imx7_defconfig \
	file://0001-arm-imx7d-add-support-for-Compulab-cl-som-imx7.patch \
	file://0002-arm-imx7d-cl-som-imx7-add-support-for-NAND-flash.patch \
	file://0003-arm-imx7d-cl-som-imx7-add-support-for-I2C4-bus.patch \
	file://0004-arm-imx7d-cl-som-imx7-add-support-for-status-LED.patch \
	file://0005-compulab-add-a-framework-for-board-specific-device-t.patch \
	file://0006-arm-imx7d-cl-som-imx7-add-support-for-board-specific.patch \
	file://0007-HACK-usb-ehci-mx6-do-not-initialize-otg2-port-for-iM.patch \
	file://0008-arm-imx7d-cl-som-imx7-add-extraversion.patch \
	file://0009-arm-imx7d-cl-som-imx7-add-support-for-watchdog.patch \
"

PACKAGE_ARCH = "${MACHINE_ARCH}"
COMPATIBLE_MACHINE = "(cl-som-imx7)"
