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
SRCREV = "b2140a50e48537680f5832141141d6db579c6e00"

S = "${WORKDIR}/git/examples/custom-client-cxx"

DEPENDS = "jsoncpp boost aktualizr"

SYSTEMD_PACKAGES += "${PN}"
SYSTEMD_SERVICE:${PN} = "${PN}.service"

do_install:append() {
    install -d ${D}${sysconfdir}/sota/conf.d/
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/systemd.service ${D}${systemd_system_unitdir}/${PN}.service
}

FILES:${PN} += "\
    ${sysconfdir}/sota/conf.d \
    ${systemd_system_unitdir}/${PN}.service \
"
