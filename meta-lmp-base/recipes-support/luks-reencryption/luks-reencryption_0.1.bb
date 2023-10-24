SUMMARY = "LUKS2 online re-encryption"
SECTION = "devel"
LICENSE = "BSD-2-Clause"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/BSD-2-Clause;md5=cb641bc04cda31daea161b1bc15da69f"

inherit allarch systemd

SRC_URI = "file://luks-reencryption \
    file://luks-reencryption.service \
"

S = "${WORKDIR}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

do_install () {
	install -d ${D}${sbindir}
	install -m 0755 ${S}/luks-reencryption ${D}${sbindir}

	install -d ${D}${systemd_system_unitdir}
	install -m 0644 ${S}/luks-reencryption.service ${D}${systemd_system_unitdir}
}

SYSTEMD_SERVICE:${PN} = "luks-reencryption.service"
SYSTEMD_AUTO_ENABLE:${PN} = "enable"
