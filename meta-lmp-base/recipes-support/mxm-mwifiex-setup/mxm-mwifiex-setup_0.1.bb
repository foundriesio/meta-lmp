SUMMARY = "Setup NXP MXM MWiFiEx kernel module"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit allarch

SRC_URI = " \
	file://modules-load-moal.conf \
	file://modprobe-moal.conf \
"

S = "${WORKDIR}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

do_install() {
	install -d ${D}${libdir}/modules-load.d
	install -m 0644 ${WORKDIR}/modules-load-moal.conf ${D}${libdir}/modules-load.d/moal.conf

	install -d ${D}${libdir}/modprobe.d
	install -m 0644 ${WORKDIR}/modprobe-moal.conf ${D}${libdir}/modprobe.d/moal.conf
}

FILES_${PN} += "${libdir}/modules-load.d/moal.conf ${libdir}/modprobe.d/moal.conf"
