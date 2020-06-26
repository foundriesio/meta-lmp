FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# The patch that adds configurable maximum of download attempts originates
# from https://github.com/docker/docker-ce/commit/74d15487080abcfce9d9359a746620a7f7c06c5b
SRC_URI_append = " \
    file://dockerd-daemon-use-default-system-config-when-none-i.patch \
    file://cli-config-support-default-system-config.patch \
    file://dockerd-daemon-configurable-max-download-attempts.patch \
    file://daemon.json.in \
"

DOCKER_MAX_CONCURRENT_DOWNLOADS ?= "3"
DOCKER_MAX_DOWNLOAD_ATTEMPTS ?= "5"

do_install_prepend() {
    sed -e 's/@@MAX_CONCURRENT_DOWNLOADS@@/${DOCKER_MAX_CONCURRENT_DOWNLOADS}/' \
        -e 's/@@MAX_DOWNLOAD_ATTEMPTS@@/${DOCKER_MAX_DOWNLOAD_ATTEMPTS}/' \
        ${WORKDIR}/daemon.json.in > ${WORKDIR}/daemon.json
}

do_install_append() {
    install -d ${D}${libdir}/docker
    install -m 0644 ${WORKDIR}/daemon.json ${D}${libdir}/docker/
}

FILES_${PN} += "${libdir}/docker"
