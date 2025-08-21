DESCRIPTION = "Custom SOTA Client example based on the aktualizr-lite C++ API"
SECTION = "base"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=504a5c2455c8bb2fc5b7667833ab1a68"

inherit pkgconfig cmake systemd

SRC_URI = "\
    git://github.com/foundriesio/sotactl;protocol=https;branch=${BRANCH} \
    file://systemd.service \
"

BRANCH = "main"
SRCREV = "7055c9a34297de50ab22e6b94e258d4e149c7455"

DEPENDS = "jsoncpp boost aktualizr"

SYSTEMD_PACKAGES += "${PN}"
SYSTEMD_SERVICE:${PN} = "${PN}.service"

do_install:append() {
    install -d ${D}${sysconfdir}/sota/conf.d/
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${UNPACKDIR}/systemd.service ${D}${systemd_system_unitdir}/${PN}.service
}

FILES:${PN} += "\
    ${sysconfdir}/sota/conf.d \
    ${systemd_system_unitdir}/${PN}.service \
"
