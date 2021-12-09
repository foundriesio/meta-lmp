FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
FILESEXTRAPATHS_prepend_lmp := "${THISDIR}/${PN}:"

SRC_URI += "file://20-docker0.conf"

do_install_append() {
    install -m 0600 ${WORKDIR}/20-docker0.conf ${D}${sysconfdir}/NetworkManager/conf.d/20-docker0.conf
}

FILES_${PN} += "${sysconfdir}/NetworkManager/conf.d/20-docker0.conf"
