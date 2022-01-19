SUMMARY = "OStree Pending Reboot service"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit allarch systemd

SRC_URI = " \
	file://ostree-pending-reboot.service \
	file://ostree-pending-reboot.timer.in \
"

S = "${WORKDIR}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

# Value is in minutes (default to check for reboot every 5 minutes)
OSTREE_PENDING_REBOOT_CHECK_MINUTES ?= "5"

PACKAGES += "${PN}-timer"
SYSTEMD_PACKAGES = "${PN} ${PN}-timer"
SYSTEMD_SERVICE:${PN} = "ostree-pending-reboot.service"
SYSTEMD_SERVICE:${PN}-timer = "ostree-pending-reboot.timer"
SYSTEMD_AUTO_ENABLE:${PN}-timer = "enable"

do_compile() {
	sed -e 's/@@OSTREE_PENDING_REBOOT_CHECK_MINUTES@@/${OSTREE_PENDING_REBOOT_CHECK_MINUTES}/' \
		${WORKDIR}/ostree-pending-reboot.timer.in > ostree-pending-reboot.timer
}

do_install () {
	install -d ${D}${systemd_system_unitdir}
	install -m 0644 ${WORKDIR}/ostree-pending-reboot.service ${D}${systemd_system_unitdir}
	install -m 0644 ${B}/ostree-pending-reboot.timer ${D}${systemd_system_unitdir}
}

FILES:${PN} += "${systemd_system_unitdir}/ostree-pending-reboot.service"
FILES:${PN} += "${systemd_system_unitdir}/ostree-pending-reboot.timer"
FILES:${PN} += "${systemd_unitdir}/system-preset"
