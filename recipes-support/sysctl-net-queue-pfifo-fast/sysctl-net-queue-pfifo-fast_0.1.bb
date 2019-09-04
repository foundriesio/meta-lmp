SUMMARY = "sysctl set net queue to pfifo_fast"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit allarch

SRC_URI = "file://sysctl-net-queuing.conf"

S = "${WORKDIR}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

do_install () {
	install -d ${D}${libdir}/sysctl.d
	install -m 0644 ${WORKDIR}/sysctl-net-queuing.conf ${D}${libdir}/sysctl.d/90-net-queuing.conf
}

FILES_${PN} += "${libdir}/sysctl.d/90-net-queuing.conf"
