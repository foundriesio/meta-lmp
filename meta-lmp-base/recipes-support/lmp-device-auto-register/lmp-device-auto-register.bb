SUMMARY = "A systemd oneshot helper to auto register a device"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

RDEPENDS:${PN} += "lmp-device-register"

SRC_URI = " \
	file://lmp-device-auto-register.service.in \
	file://lmp-device-auto-register \
	file://api-token \
"

inherit systemd

SYSTEMD_SERVICE:${PN} = "lmp-device-auto-register.service"
LMP_AUTO_REGISTER_USE_HOSTNAME ?= ""

do_compile() {
    sed -e 's/@@LMP_AUTO_REGISTER_USE_HOSTNAME@@/${LMP_AUTO_REGISTER_USE_HOSTNAME}/' \
        ${WORKDIR}/lmp-device-auto-register.service.in > ${WORKDIR}/lmp-device-auto-register.service
}

do_install() {
	install -d ${D}${systemd_system_unitdir}
	install -m 0644 ${WORKDIR}/lmp-device-auto-register.service ${D}${systemd_system_unitdir}/
	install -d ${D}${bindir}
	install -m 0755 ${WORKDIR}/lmp-device-auto-register ${D}${bindir}/
	install -d ${D}${sysconfdir}
	install -m 0600 ${WORKDIR}/api-token ${D}${sysconfdir}/lmp-device-register-token
}
