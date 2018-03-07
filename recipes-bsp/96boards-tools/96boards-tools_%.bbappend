FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append += " \
    file://0001-resize-helper.service-wait-for-udevadm-settle-before.patch \
    file://resize-helper-force-if-already-mounted.patch \
    file://btattach.service \
"

SRC_URI_append_dragonboard-820c += " \
    file://btattach.dragonboard-820c \
"

do_install_append () {
    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/btattach.service ${D}${systemd_unitdir}/system
}

do_install_append_dragonboard-820c () {
    install -d ${D}${sysconfdir}/bluetooth
    install -m 0755 ${WORKDIR}/btattach.dragonboard-820c ${D}${sysconfdir}/bluetooth/btattach.conf
}

SYSTEMD_SERVICE_${PN}_append += "btattach.service"
