FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI:append = " \
    file://0001-cli-config-support-default-system-config.patch;patchdir=cli \
    file://0001-dockerd-daemon-use-default-system-config-when-none-i.patch;patchdir=src/import \
    file://0002-remote_daemon-increase-containerd-default-timeouts.patch;patchdir=src/import \
    file://0003-registry-increase-TLS-and-connection-timeouts.patch;patchdir=src/import \
    file://0004-layer-Ensure-layer-files-are-synced-to-disk.patch;patchdir=src/import \
    file://0005-tarexport-Optimize-image-loading-on-local-host.patch;patchdir=src/import \
    file://daemon.json.in \
    file://docker.service \
"

DOCKER_MAX_CONCURRENT_DOWNLOADS ?= "3"
DOCKER_MAX_DOWNLOAD_ATTEMPTS ?= "5"
DOCKER_DAEMON_JSON_CUSTOM ?= ""

# Prefer docker.service instead of docker.socket as this is a critical service
SYSTEMD_SERVICE:${PN} = "${@bb.utils.contains('DISTRO_FEATURES','systemd','docker.service','',d)}"

do_install:prepend() {
    sed -e 's/@@MAX_CONCURRENT_DOWNLOADS@@/${DOCKER_MAX_CONCURRENT_DOWNLOADS}/' \
        -e 's/@@MAX_DOWNLOAD_ATTEMPTS@@/${DOCKER_MAX_DOWNLOAD_ATTEMPTS}/' \
        -e 's/@@DOCKER_DAEMON_JSON_CUSTOM@@/${DOCKER_DAEMON_JSON_CUSTOM}/' \
        ${UNPACKDIR}/daemon.json.in > ${UNPACKDIR}/daemon.json
}

do_install:append() {
    install -d ${D}${libdir}/docker
    install -m 0644 ${UNPACKDIR}/daemon.json ${D}${libdir}/docker/

    # Replace default docker.service with the one provided by this recipe
    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
        install -m 644 ${UNPACKDIR}/docker.service ${D}/${systemd_unitdir}/system
    fi
}

# pigz takes advantage of both multiple CPUs and multiple CPU cores for higher
# compression and decompression speed, and also set at the official packages
RDEPENDS:${PN} += "pigz"
FILES:${PN} += "${libdir}/docker"
