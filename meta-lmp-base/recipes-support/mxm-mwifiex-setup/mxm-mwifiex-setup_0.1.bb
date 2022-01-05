SUMMARY = "Setup NXP MXM MWiFiEx kernel module"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit allarch

SRC_URI = " \
	file://modules-load-moal.conf \
	file://modprobe-moal.conf \
"

S = "${WORKDIR}"

do_install() {
	install -d ${D}${sysconfdir}/modules-load.d
	install -m 0644 ${WORKDIR}/modules-load-moal.conf ${D}${sysconfdir}/modules-load.d/moal.conf

	install -d ${D}${sysconfdir}/modprobe.d
	install -m 0644 ${WORKDIR}/modprobe-moal.conf ${D}${sysconfdir}/modprobe.d/moal.conf
}

FILES_${PN} += "${sysconfdir}/modules-load.d/moal.conf ${sysconfdir}/modprobe.d/moal.conf"
