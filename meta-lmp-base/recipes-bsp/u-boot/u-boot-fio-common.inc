HOMEPAGE = "http://www.denx.de/wiki/U-Boot/WebHome"
DESCRIPTION = "U-Boot, a boot loader for Embedded boards based on PowerPC, \
ARM, MIPS and several other processors, which can be installed in a boot \
ROM and used to initialize and test the hardware or to download and run \
application code."
SECTION = "bootloaders"
LICENSE = "GPL-2.0-or-later"
LIC_FILES_CHKSUM = "file://Licenses/README;md5=30503fd321432fc713238f582193b78e"
DEPENDS += "flex-native bison-native bc-native dtc-native python3-setuptools-native gnutls-native"

UBOOT_REPO ??= "git://github.com/foundriesio/u-boot.git"

SRC_URI = "${UBOOT_REPO};protocol=https;branch=${SRCBRANCH} \
    file://fw_env.config \
    ${@bb.utils.contains('MACHINE_FEATURES', 'ebbr', 'file://lmp-ebbr.cfg', 'file://lmp.cfg', d)} \
"
# LMP base requires a different u-boot configuration fragment
SRC_URI:append:lmp-base = " file://lmp-base.cfg "
SRC_URI:remove:lmp-base = "file://lmp.cfg"

S = "${WORKDIR}/git"
B = "${WORKDIR}/build"
do_configure[cleandirs] = "${B}"

require recipes-bsp/u-boot/u-boot.inc
require recipes-bsp/u-boot/u-boot-lmp-common.inc

# Support additional u-boot classes such as u-boot-fitimage
UBOOT_CLASSES ?= ""
inherit ${UBOOT_CLASSES} fio-u-boot-localversion

PROVIDES += "u-boot"
