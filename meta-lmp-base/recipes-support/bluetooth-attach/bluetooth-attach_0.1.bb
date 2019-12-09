SUMMARY = "Bluetooth Serial Attach Initialization"
SECTION = "devel"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

inherit allarch systemd

RDEPENDS_${PN} += "bluez5"

SRC_URI = "file://btattach.service"

S = "${WORKDIR}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

do_install () {
	install -d ${D}${systemd_system_unitdir}
	install -m 0644 ${S}/btattach.service ${D}${systemd_system_unitdir}
}

SYSTEMD_SERVICE_${PN} = "btattach.service"
