SUMMARY = "Foundries.io Diagnostic Tool for a Device"
SECTION = "devel"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/BSD-3-Clause;md5=550794465ba0ec5312d6919e203a55f9"
HOMEPAGE = "https://github.com/foundriesio/lmp-tools/tree/master/device-scripts"

SRCREV = "068c4566306efbca6cc8749c07decc4a8e9a2625"

SRC_URI = " \
    git://github.com/foundriesio/lmp-tools;protocol=https;branch=master;name=lmp-tools \
"

PACKAGE_ARCH = "${MACHINE_ARCH}"

do_install () {
	install -d ${D}${sbindir}
	install -m 0755 ${S}/device-scripts/fio-diag.sh ${D}${sbindir}
}
