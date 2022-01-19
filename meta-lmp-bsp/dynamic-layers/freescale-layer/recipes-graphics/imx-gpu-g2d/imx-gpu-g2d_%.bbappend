# /opt is not valid under ostree
do_install:append() {
    install -d ${D}${datadir}/${PN}
    mv ${D}/opt/* ${D}${datadir}/${PN}
}

FILES:${PN} += "${datadir}"
