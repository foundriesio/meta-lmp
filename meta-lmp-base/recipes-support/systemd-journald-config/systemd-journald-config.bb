SUMMARY = "Systemd Journald Configuration Fragment"
SECTION = "devel"
LICENSE = "BSD-2-Clause"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/BSD-2-Clause;md5=cb641bc04cda31daea161b1bc15da69f"

inherit allarch

SRC_URI = "file://forward-console.conf"

S = "${WORKDIR}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

do_install() {
    install -d ${D}${systemd_unitdir}/journald.conf.d
    install -m 0644 ${S}/forward-console.conf ${D}${systemd_unitdir}/journald.conf.d/10-forward-console.conf
}

FILES_${PN} = "${systemd_unitdir}/journald.conf.d"
