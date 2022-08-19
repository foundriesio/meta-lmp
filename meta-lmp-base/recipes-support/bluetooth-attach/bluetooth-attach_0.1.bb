SUMMARY = "Bluetooth Serial Attach Initialization"
SECTION = "devel"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

inherit allarch systemd

RDEPENDS:${PN} += "bluez5"

SRC_URI = " \
    file://btattach.service \
    file://btattach.conf \
"

S = "${WORKDIR}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

do_install () {
	install -d ${D}${systemd_system_unitdir}
	install -m 0644 ${S}/btattach.service ${D}${systemd_system_unitdir}
	install -d ${D}${sysconfdir}/bluetooth/
	install -m 0644 ${S}/btattach.conf ${D}${sysconfdir}/bluetooth/
}

SYSTEMD_SERVICE:${PN} = "btattach.service"

FILES_${PN} += "${sysconfdir}/bluetooth/btattach.conf"
