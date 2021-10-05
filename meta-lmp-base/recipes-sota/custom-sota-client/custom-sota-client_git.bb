DESCRIPTION = "Custom SOTA Client example based on the aktualizr-lite C++ API"
SECTION = "base"
LICENSE = "MPL-2.0"
LIC_FILES_CHKSUM = "file://${WORKDIR}/git/LICENSE;md5=815ca599c9df247a0c7f619bab123dad"

inherit pkgconfig cmake systemd

SRC_URI = "\
    git://github.com/foundriesio/aktualizr-lite;protocol=https;branch=${BRANCH} \
    file://systemd.service \
"

BRANCH = "master"
SRCREV = "05c4180840ef84c21b0632be4a542580d720491f"

S = "${WORKDIR}/git/examples/custom-client-cxx"

DEPENDS = "jsoncpp boost aktualizr"

SYSTEMD_PACKAGES += "${PN}"
SYSTEMD_SERVICE_${PN} = "${PN}.service"

do_install_append() {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/systemd.service ${D}${systemd_system_unitdir}/${PN}.service
}

FILES_${PN} += "${systemd_unitdir}/system/${PN}.service"
