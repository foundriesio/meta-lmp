HOMEPAGE = "http://www.denx.de/wiki/U-Boot/WebHome"
DESCRIPTION = "U-Boot, a boot loader for Embedded boards based on PowerPC, \
ARM, MIPS and several other processors, which can be installed in a boot \
ROM and used to initialize and test the hardware or to download and run \
application code."
SECTION = "bootloaders"
LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://Licenses/README;md5=30503fd321432fc713238f582193b78e"
DEPENDS += "flex-native bison-native bc-native dtc-native"

SRCREV = "c3dc488020e6be81490b14955c09038814637ae0"
SRCBRANCH = "2019.10+fio"

SRC_URI = "git://github.com/foundriesio/u-boot.git;branch=${SRCBRANCH} \
    file://fw_env.config \
    file://lmp.cfg \
"

PV = "v2019.10+git${SRCPV}"

S = "${WORKDIR}/git"
B = "${WORKDIR}/build"
do_configure[cleandirs] = "${B}"

require recipes-bsp/u-boot/u-boot.inc

# Support additional u-boot classes such as u-boot-fitimage
UBOOT_CLASSES ?= ""
inherit ${UBOOT_CLASSES}

RDEPENDS_${PN}_append_sota = " u-boot-ostree-scr"

PROVIDES += "u-boot"
