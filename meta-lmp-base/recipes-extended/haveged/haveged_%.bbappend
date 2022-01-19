FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
    file://haveged.service \
"

do_install:append() {
    install -m 0644 ${WORKDIR}/haveged.service ${D}${systemd_system_unitdir}/
}
