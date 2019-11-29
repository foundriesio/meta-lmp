HOMEPAGE = "http://www.denx.de/wiki/U-Boot/WebHome"
DESCRIPTION = "U-Boot, a boot loader for Embedded boards based on PowerPC, \
ARM, MIPS and several other processors, which can be installed in a boot \
ROM and used to initialize and test the hardware or to download and run \
application code."
SECTION = "bootloaders"
LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://Licenses/README;md5=30503fd321432fc713238f582193b78e"
DEPENDS += "flex-native bison-native"

SRCREV = "639d4735e6295546342325d7f8690d08da7b65fb"
SRCBRANCH = "2019.10+fio"

SRC_URI = "git://github.com/foundriesio/u-boot.git;branch=${SRCBRANCH}"

PV = "v2019.10+git${SRCPV}"

S = "${WORKDIR}/git"
