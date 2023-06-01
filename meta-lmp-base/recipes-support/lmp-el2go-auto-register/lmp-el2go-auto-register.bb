SUMMARY = "A systemd oneshot helper to auto register a device using EdgeLock2GO"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

RDEPENDS:${PN} += "python3-core opensc fio-se05x-cli"

SRC_URI = " \
	file://lmp-el2go-auto-register.service \
	file://lmp-el2go-auto-register \
	file://default.env \
	file://root.crt \
"

inherit systemd

SYSTEMD_SERVICE:${PN} = "lmp-el2go-auto-register.service"

do_install() {
	install -d ${D}${systemd_system_unitdir}
	install -m 0644 ${WORKDIR}/lmp-el2go-auto-register.service ${D}${systemd_system_unitdir}
	install -d ${D}${bindir}
	install -m 0755 ${WORKDIR}/lmp-el2go-auto-register ${D}${bindir}
	install -d ${D}${sysconfdir}/default
	install -m 0644 ${WORKDIR}/default.env ${D}${sysconfdir}/default/lmp-el2go-auto-register
	install -d ${D}${datadir}/lmp-el2go-auto-register
	install -m 0644 ${WORKDIR}/root.crt ${D}${datadir}/lmp-el2go-auto-register
}
