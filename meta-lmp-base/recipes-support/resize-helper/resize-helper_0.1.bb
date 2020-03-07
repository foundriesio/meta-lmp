SUMMARY = "Rootfs disk resize-helper"
SECTION = "devel"
LICENSE = "BSD-2-Clause"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/BSD-2-Clause;md5=cb641bc04cda31daea161b1bc15da69f"

inherit allarch systemd

RDEPENDS_${PN} += "e2fsprogs-resize2fs gptfdisk parted util-linux-findmnt"

SRC_URI = "file://resize-helper \
    file://resize-helper.service \
"

S = "${WORKDIR}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

do_install () {
	install -d ${D}${sbindir}
	install -m 0755 ${S}/resize-helper ${D}${sbindir}

	install -d ${D}${systemd_system_unitdir}
	install -m 0644 ${S}/resize-helper.service ${D}${systemd_system_unitdir}
}

SYSTEMD_SERVICE_${PN} = "resize-helper.service"
SYSTEMD_AUTO_ENABLE_${PN} = "enable"
