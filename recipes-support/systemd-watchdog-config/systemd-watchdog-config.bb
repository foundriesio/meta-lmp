SUMMARY = "Systemd Watchdog Configuration Fragment"
SECTION = "devel"
LICENSE = "BSD-2-Clause"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/BSD-2-Clause;md5=cb641bc04cda31daea161b1bc15da69f"

inherit allarch

SRC_URI = "file://watchdog.conf"

S = "${WORKDIR}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

do_install () {
    install -d ${D}${systemd_unitdir}/system.conf.d
    install -m 0644 ${S}/watchdog.conf ${D}${systemd_unitdir}/system.conf.d/10-watchdog.conf
}

FILES_${PN} = "${systemd_unitdir}/system.conf.d"
