FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append += " \
    file://Revert-resize-helper.service-use-conditionfirstboot-directive.patch \
    file://hciattach.service \
"

SRC_URI_append_dragonboard-820c += " \
    file://hciattach.dragonboard-820c \
"

do_install_append () {
    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/hciattach.service ${D}${systemd_unitdir}/system
}

do_install_append_dragonboard-820c () {
    install -d ${D}${sysconfdir}/bluetooth
    install -m 0755 ${WORKDIR}/hciattach.dragonboard-820c ${D}${sysconfdir}/bluetooth/hciattach.conf
}

SYSTEMD_SERVICE_${PN}_append += "hciattach.service"
