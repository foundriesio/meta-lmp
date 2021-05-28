SUMMARY = "Rootfs disk resize-helper for mfgtools"
SECTION = "devel"
LICENSE = "BSD-2-Clause"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/BSD-2-Clause;md5=cb641bc04cda31daea161b1bc15da69f"

inherit allarch

RDEPENDS_${PN} += "udev e2fsprogs-resize2fs e2fsprogs-e2fsck gptfdisk parted"

SRC_URI = "file://mfgtool-resize-helper \
"

S = "${WORKDIR}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

do_install () {
	install -d ${D}${sbindir}
	install -m 0755 ${S}/mfgtool-resize-helper ${D}${sbindir}
}
