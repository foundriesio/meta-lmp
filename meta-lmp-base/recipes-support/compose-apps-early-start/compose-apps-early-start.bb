SUMMARY = "A systemd oneshot helper to start compose apps as early as possible"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = " \
	file://compose-apps-early-start.service \
	file://compose-apps-early-start \
"

inherit systemd

SYSTEMD_SERVICE_${PN} = "compose-apps-early-start.service"

do_install() {
	install -d ${D}${systemd_system_unitdir}
	install -m 0644 ${WORKDIR}/compose-apps-early-start.service ${D}${systemd_system_unitdir}/
	install -d ${D}${bindir}
	install -m 0755 ${WORKDIR}/compose-apps-early-start ${D}${bindir}/
}
