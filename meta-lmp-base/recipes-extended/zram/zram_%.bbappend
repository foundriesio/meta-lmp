FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://zram.conf"

do_install_append() {
    install -d ${D}${sysconfdir}/default
    install -m 0644 ${WORKDIR}/zram.conf ${D}${sysconfdir}/default/zram
}
