FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append += " \
    file://resize-helper-force-if-already-mounted.patch \
    file://btattach.service \
"

do_install_append () {
    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/btattach.service ${D}${systemd_unitdir}/system
}

SYSTEMD_SERVICE_${PN}_append += "btattach.service"
