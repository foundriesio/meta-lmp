FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
    file://daemon.json.in \
    file://docker.service \
    file://0001-cli-config-support-default-system-config.patch;patchdir=cli \
    file://0001-dockerd-daemon-use-default-system-config-when-none-i.patch;patchdir=src/import \
    file://0002-remote_daemon-Bump-healthcheck-startup-and-shutdown-.patch;patchdir=src/import \
    file://0003-registry-increase-TLS-and-connection-timeouts.patch;patchdir=src/import \
    file://0004-overlay2-fsync-layer-metadata-files.patch;patchdir=src/import \
    file://0005-Fsync-layer-once-extracted-to-file-system.patch;patchdir=src/import \
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
