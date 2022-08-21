FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
    file://daemon.json.in \
    file://docker.service \
    file://dockerd-daemon-use-default-system-config-when-none-i.patch \
    file://cli-config-support-default-system-config.patch \
    file://increase_containerd_timeouts.patch \
    file://0001-registry-increase-TLS-and-connection-timeouts.patch \
    file://0001-overlay2-fsync-layer-metadata-files.patch \
    file://0001-Revert-20.10-vendor-update-archive-tar-for-go-1.18.patch \
    file://0001-Fsync-layer-once-extracted-to-file-system.patch \
"

DOCKER_MAX_CONCURRENT_DOWNLOADS ?= "3"
DOCKER_MAX_DOWNLOAD_ATTEMPTS ?= "5"

# Prefer docker.service instead of docker.socket as this is a critical service
SYSTEMD_SERVICE:${PN} = "${@bb.utils.contains('DISTRO_FEATURES','systemd','docker.service','',d)}"

do_install:prepend() {
    sed -e 's/@@MAX_CONCURRENT_DOWNLOADS@@/${DOCKER_MAX_CONCURRENT_DOWNLOADS}/' \
        -e 's/@@MAX_DOWNLOAD_ATTEMPTS@@/${DOCKER_MAX_DOWNLOAD_ATTEMPTS}/' \
        ${WORKDIR}/daemon.json.in > ${WORKDIR}/daemon.json
}

do_install:append() {
    install -d ${D}${libdir}/docker
    install -m 0644 ${WORKDIR}/daemon.json ${D}${libdir}/docker/

    # Replace default docker.service with the one provided by this recipe
    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
        install -m 644 ${WORKDIR}/docker.service ${D}/${systemd_unitdir}/system
    fi
}

# pigz takes advantage of both multiple CPUs and multiple CPU cores for higher
# compression and decompression speed, and also set at the official packages
RDEPENDS:${PN} += "pigz"
FILES:${PN} += "${libdir}/docker"
