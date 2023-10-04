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
"

# Handle lmp / lmp-mfgtool distro configs set
SRC_URI:append = " \
    ${@bb.utils.contains('MACHINE_FEATURES', 'ebbr', 'file://lmp-common-ebbr.cfg', 'file://lmp-common.cfg', d)} \
    ${@bb.utils.contains('MACHINE_FEATURES', 'ebbr', 'file://lmp-ebbr.cfg', 'file://lmp.cfg', d)} \
    ${@bb.utils.contains('UBOOT_SIGN_ENABLE', '1', '', 'file://lmp-common-nosec.cfg', d)} \
"

# LMP base requires different u-boot configuration fragments
SRC_URI:append:lmp-base = " file://lmp-common-base.cfg file://lmp-base.cfg "
SRC_URI:remove:lmp-base = "file://lmp.cfg"
SRC_URI:remove:lmp-base = "file://lmp-common.cfg"
SRC_URI:remove:lmp-base = "file://lmp-common-nosec.cfg"

S = "${WORKDIR}/git"
B = "${WORKDIR}/build"
do_configure[cleandirs] = "${B}"

require recipes-bsp/u-boot/u-boot.inc
require recipes-bsp/u-boot/u-boot-lmp-common.inc

# Support additional u-boot classes such as u-boot-fitimage
UBOOT_CLASSES ?= ""
inherit ${UBOOT_CLASSES} fio-u-boot-localversion

PROVIDES += "u-boot"

# setting DEPENDS create dependency loops so skip the check
LMPSTAGING_DEPLOYED_CHECK_SKIP += "${PN}:do_deploy"
