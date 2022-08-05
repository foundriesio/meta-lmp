FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://ckteec.module"

do_install:append() {
    install -d ${D}${datadir}/p11-kit/modules
    install -m 0644 ${WORKDIR}/ckteec.module ${D}${datadir}/p11-kit/modules/ckteec.module
}

FILES:${PN} += "${datadir}/p11-kit/modules"
