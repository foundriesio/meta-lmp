SUMMARY = "Default system configuration file for Docker cli"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit allarch

SRC_URI = "file://config.json.in"

S = "${WORKDIR}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

FIO_HUB_URL ?= "hub.foundries.io"

do_compile() {
    sed -e 's|@@HUB_URL@@|${FIO_HUB_URL}|g' \
        ${WORKDIR}/config.json.in > ${B}/config.json
}

do_install() {
        install -d ${D}${libdir}/docker
        install -m 0644 ${B}/config.json ${D}${libdir}/docker/config.json
}

FILES:${PN} += "${libdir}/docker"
