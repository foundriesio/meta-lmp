SUMMARY = "A systemd oneshot helper to auto register a device using EdgeLock2GO"
HOMEPAGE = "https://github.com/foundriesio/lmp-el2go-auto-register"
SECTION = "devel"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "git://github.com/foundriesio/lmp-el2go-auto-register.git;protocol=https;branch=main \
	file://default.env \
	file://root.crt \
"
SRCREV = "302d47ee8e8daaa3febbfe3b4b27f80d16bb4aee"

S = "${WORKDIR}/git"

RDEPENDS:${PN} += "python3-core opensc fio-se05x-cli"

inherit systemd

SYSTEMD_SERVICE:${PN} = "lmp-el2go-auto-register.service"

do_install() {
	install -d ${D}${systemd_system_unitdir}
	install -m 0644 ${S}/lmp-el2go-auto-register.service ${D}${systemd_system_unitdir}
	install -d ${D}${bindir}
	install -m 0755 ${S}/lmp-el2go-auto-register ${D}${bindir}
	install -d ${D}${sysconfdir}/default
	install -m 0644 ${WORKDIR}/default.env ${D}${sysconfdir}/default/lmp-el2go-auto-register
	install -d ${D}${datadir}/lmp-el2go-auto-register
	install -m 0644 ${WORKDIR}/root.crt ${D}${datadir}/lmp-el2go-auto-register
}
