SUMMARY = "foundries diagnostic tool"
SECTION = "devel"
LICENSE = "BSD-2-Clause"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/BSD-2-Clause;md5=cb641bc04cda31daea161b1bc15da69f"

SRCREV = "4096c9b825155273b2ec72dccbde45a904b7c9b5"

SRC_URI = " \
    gitsm://github.com/foundriesio/lmp-tools;protocol=https;branch=master;name=lmp-tools \
"

S = "${WORKDIR}/git/device-scripts"

PACKAGE_ARCH = "${MACHINE_ARCH}"

do_install () {
	install -d ${D}${sbindir}
	install -m 0755 ${S}/fio-diag.sh ${D}${sbindir}
}
