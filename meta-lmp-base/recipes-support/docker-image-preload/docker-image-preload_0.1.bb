SUMMARY = "Systemd service for preloading of container images"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit allarch systemd

SRC_URI = "file://docker-image-preload.service"

PACKAGE_ARCH = "${MACHINE_ARCH}"

SYSTEMD_SERVICE_${PN} = "docker-image-preload.service"
SYSTEMD_AUTO_ENABLE_${PN} = "enable"

do_install() {
  install -d ${D}${systemd_system_unitdir}
  install -m 0644 ${WORKDIR}/docker-image-preload.service ${D}${systemd_system_unitdir}
}

FILES_${PN} += "${systemd_system_unitdir}/docker-image-preload.service"
