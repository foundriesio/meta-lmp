SUMMARY = "A systemd oneshot helper to auto register a device"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"
RDEPENDS_lmp-device-auto-register = "lmp-device-register"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRC_URI = " \
	file://lmp-device-auto-register.service \
	file://lmp-device-auto-register \
	file://api-token \
"

inherit systemd

SYSTEMD_SERVICE_${PN} = "lmp-device-auto-register.service"

do_install() {
	install -d ${D}${systemd_system_unitdir}
	install -m 0644 ${WORKDIR}/lmp-device-auto-register.service ${D}${systemd_system_unitdir}/
	install -d ${D}${bindir}
	install -m 0755 ${WORKDIR}/lmp-device-auto-register ${D}${bindir}/
	install -d ${D}${sysconfdir}
	install -m 0755 ${WORKDIR}/api-token ${D}${sysconfdir}/lmp-device-register-token
}
