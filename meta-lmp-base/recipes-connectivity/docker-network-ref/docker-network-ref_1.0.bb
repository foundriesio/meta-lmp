SUMMARY = "Auto creation of the `docker-network-ref` docker bridge network"
LICENSE = "BSD-2-Clause"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/BSD-2-Clause;md5=cb641bc04cda31daea161b1bc15da69f"

inherit systemd

SYSTEMD_AUTO_ENABLE = "enable"
SYSTEMD_SERVICE:${PN} = "docker-network-ref.service"

SRC_URI = " \
    file://create-docker-ref-network.sh.in \
    file://docker-network-ref.service \
"

S = "${UNPACKDIR}"

DOCKER_NETWORK_NAME ?= "docker-network-ref"

do_compile() {
    sed -e 's|@@DOCKER_NETWORK_NAME@@|${DOCKER_NETWORK_NAME}|g' \
        ${UNPACKDIR}/create-docker-ref-network.sh.in > ${B}/create-docker-ref-network.sh
}

do_install() {
    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${UNPACKDIR}/docker-network-ref.service ${D}${systemd_unitdir}/system
    install -d ${D}${sbindir}
    install -m 0755 ${B}/create-docker-ref-network.sh ${D}${sbindir}/
}

FILES:${PN} = " \
    ${systemd_unitdir}/system/docker-network-ref.service \
    ${sbindir}/create-docker-ref-network.sh \
"
