SUMMARY = "Add all sbin dirs to PATH for root user"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit allarch

SRC_URI = "file://path-sbin.sh"

S = "${WORKDIR}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

do_install () {
	# Useful for development
	install -d ${D}${sysconfdir}/profile.d
	install -m 0644 ${WORKDIR}/path-sbin.sh ${D}${sysconfdir}/profile.d/path-sbin.sh
}

FILES_${PN} += "${sysconfdir}/profile.d/path-sbin.sh"
