DESCRIPTION = "A small tool to provide detailed information on the hardware \
configuration of the machine. It can report exact memory configuration, \
firmware version, mainboard configuration, CPU version and speed, cache \
configuration, bus speed, etc. on DMI-capable or EFI systems."
SUMMARY = "Hardware lister"
HOMEPAGE = "http://ezix.org/project/wiki/HardwareLiSter"
SECTION = "console/tools"
LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://COPYING;md5=b234ee4d69f5fce4486a80fdaf4a4263"

DEPENDS = "gettext-native pciutils usbutils"
COMPATIBLE_HOST = "(i.86|x86_64|arm|aarch64|riscv64).*-linux"

SRC_URI = "git://github.com/lyonel/lshw.git;protocol=https;branch=master \
    file://docbook2man.patch \
"

SRCREV = "996aaad9c760efa6b6ffef8518999ec226af049a"

S = "${WORKDIR}/git"

do_compile() {
    # build core only - don't ship gui
    oe_runmake -C src core
}

do_install() {
    oe_runmake install DESTDIR=${D}
    # data files provided by dependencies
    rm -rf ${D}/usr/share/lshw
}
