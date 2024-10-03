SUMMARY = "Sets up a CDI device entry for the Wayland display"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit allarch systemd

SRC_URI = "file://wayland-cdi.service \
    file://wayland-cdi-generate \
"

SYSTEMD_SERVICE:${PN} = "wayland-cdi.service"
SYSTEMD_AUTO_ENABLE:${PN} = "enable"

do_install() {
	install -d ${D}${bindir}
	install -m 0755 ${WORKDIR}/wayland-cdi-generate ${D}${bindir}/wayland-cdi-generate

	install -d ${D}${systemd_system_unitdir}
	install -m 0644 ${WORKDIR}/wayland-cdi.service ${D}${systemd_system_unitdir}
}
