SUMMARY = "A systemd oneshot helper to start compose apps as early as possible"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = " \
	file://compose-apps-early-start-recovery.service \
	file://compose-apps-early-start.service \
	file://compose-apps-early-start-recovery \
	file://compose-apps-early-start \
	file://compose-apps-register-images.service \
"

inherit systemd

SYSTEMD_SERVICE:${PN} = "compose-apps-early-start.service compose-apps-register-images.service"

do_install() {
	install -d ${D}${systemd_system_unitdir}
	install -m 0644 ${WORKDIR}/compose-apps-early-start.service ${D}${systemd_system_unitdir}/
	install -m 0644 ${WORKDIR}/compose-apps-early-start-recovery.service ${D}${systemd_system_unitdir}/
	install -m 0644 ${WORKDIR}/compose-apps-register-images.service ${D}${systemd_system_unitdir}/
	install -d ${D}${bindir}
	install -m 0755 ${WORKDIR}/compose-apps-early-start ${D}${bindir}/
	install -m 0755 ${WORKDIR}/compose-apps-early-start-recovery ${D}${bindir}/
}

FILES:${PN} += "${systemd_system_unitdir}/*.service"
