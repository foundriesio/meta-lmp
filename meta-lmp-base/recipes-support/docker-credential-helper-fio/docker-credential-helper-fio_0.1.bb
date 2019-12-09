SUMMARY = "Docker-credential helper to handle hub.foundries.io for registered devices"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit allarch

RDEPENDS_${PN} = "aktualizr-get"

SRC_URI = "file://docker-credential-fio-helper"
S = "${WORKDIR}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

do_install() {
	install -d ${D}${bindir}
	install -m 0755 docker-credential-fio-helper ${D}${bindir}
}
