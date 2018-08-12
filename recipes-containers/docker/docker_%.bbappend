FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " \
    file://custom-dockerd-config.patch \
    file://daemon.json \
"

do_install_append() {
    install -d ${D}${libdir}/docker
    install -m 0644 ${WORKDIR}/daemon.json ${D}${libdir}/docker/
}

INHIBIT_PACKAGE_STRIP = "0"
