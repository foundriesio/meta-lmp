# /opt is not valid under ostree
do_install_append() {
    install -d ${D}${datadir}/${PN}
    mv ${D}/opt/* ${D}${datadir}/${PN}
}

FILES_${PN} += "${datadir}"
