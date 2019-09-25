SUMMARY = "Default system configuration file for Docker cli"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit allarch

SRC_URI = "file://config.json"

S = "${WORKDIR}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

do_install() {
        install -d ${D}${libdir}/docker
        install -m 0644 ${WORKDIR}/config.json ${D}${libdir}/docker/config.json
}

FILES_${PN} += "${libdir}/docker"
