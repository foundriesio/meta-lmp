FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " \
    file://dockerd-daemon-use-default-system-config-when-none-i.patch \
    file://cli-config-support-default-system-config.patch \
    file://daemon.json.in \
"

DOCKER_MAX_CONCURRENT_DOWNLOADS ?= "3"

do_install_prepend() {
    sed -e 's/@@MAX_CONCURRENT_DOWNLOADS@@/${DOCKER_MAX_CONCURRENT_DOWNLOADS}/' ${WORKDIR}/daemon.json.in > ${WORKDIR}/daemon.json
}

do_install_append() {
    install -d ${D}${libdir}/docker
    install -m 0644 ${WORKDIR}/daemon.json ${D}${libdir}/docker/
}

FILES_${PN} += "${libdir}/docker"
