FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " \
    file://haveged.service \
"

do_install_append() {
    install -m 0644 ${WORKDIR}/haveged.service ${D}${systemd_system_unitdir}/
}
