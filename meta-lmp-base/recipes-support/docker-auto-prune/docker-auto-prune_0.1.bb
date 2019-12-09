SUMMARY = "Automatic Docker System Prune service for removal of unused data"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit allarch systemd

SRC_URI = "file://docker-auto-prune.service \
    file://docker-auto-prune.timer.in \
"

PACKAGE_ARCH = "${MACHINE_ARCH}"

# Allow build time customizations by the user
DOCKER_PRUNE_ONCALENDAR ?= "daily"

SYSTEMD_SERVICE_${PN} = "docker-auto-prune.timer"
SYSTEMD_AUTO_ENABLE_${PN} = "enable"

do_compile() {
	sed -e 's/@@DOCKER_PRUNE_ONCALENDAR@@/${DOCKER_PRUNE_ONCALENDAR}/' \
		${WORKDIR}/docker-auto-prune.timer.in > docker-auto-prune.timer
}

do_install() {
	install -d ${D}${systemd_system_unitdir}
	install -m 0644 ${WORKDIR}/docker-auto-prune.service ${D}${systemd_system_unitdir}
	install -m 0644 ${B}/docker-auto-prune.timer ${D}${systemd_system_unitdir}
}

FILES_${PN} += "${systemd_system_unitdir}/docker-auto-prune.service"
