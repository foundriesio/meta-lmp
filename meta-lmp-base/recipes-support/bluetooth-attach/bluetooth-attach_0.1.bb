SUMMARY = "Bluetooth Serial Attach Initialization"
SECTION = "devel"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

inherit allarch systemd

RDEPENDS:${PN} += "bluez5"

SRC_URI = " \
    file://btattach.service \
    file://btattach.conf \
    file://hciattach.service \
    file://hciattach.conf \
    file://hciattach-custom.sh \
"

S = "${UNPACKDIR}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

# By default, no need for custom hci port setup
HCI_ATTACH_BOARD ?= "INCOMPATIBLE BOARD"

do_install () {
	install -d ${D}${systemd_system_unitdir}
	install -m 0644 ${S}/btattach.service ${D}${systemd_system_unitdir}
	install -m 0644 ${S}/hciattach.service ${D}${systemd_system_unitdir}
	sed -i 's/@@HCI_ATTACH_BOARD@@/${HCI_ATTACH_BOARD}/' ${D}${systemd_system_unitdir}/hciattach.service

	install -d ${D}${sysconfdir}/bluetooth/
	install -m 0644 ${S}/btattach.conf ${D}${sysconfdir}/bluetooth/
	install -m 0644 ${S}/hciattach.conf ${D}${sysconfdir}/bluetooth/

	install -d ${D}${bindir}
	install -m 0755 ${S}/hciattach-custom.sh ${D}${bindir}
}

SYSTEMD_SERVICE:${PN} = "btattach.service hciattach.service"

FILES:${PN} += " \
    ${sysconfdir}/bluetooth/btattach.conf \
    ${sysconfdir}/bluetooth/hciattach.conf \
    ${bindir}/hciattach-custom.sh \
"
