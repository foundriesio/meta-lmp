SUMMARY = "Automatic hostname update based on hardware specific information"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit allarch systemd

RDEPENDS_${PN} = "systemd"

SRC_URI = "file://lmp-auto-hostname.service.in \
    file://lmp-update-hostname.sh \
"

PACKAGE_ARCH = "${MACHINE_ARCH}"

# Allow build time customizations by the user
LMP_HOSTNAME_MACHINE ?= "${MACHINE}"
LMP_HOSTNAME_MODE ?= "serial"
LMP_HOSTNAME_NETDEVICE ?= ""

SYSTEMD_SERVICE_${PN} = "lmp-auto-hostname.service"
SYSTEMD_AUTO_ENABLE_${PN} = "enable"

do_compile() {
	sed -e 's/@@LMP_HOSTNAME_MACHINE@@/${LMP_HOSTNAME_MACHINE}/' \
		-e 's/@@LMP_HOSTNAME_MODE@@/${LMP_HOSTNAME_MODE}/' \
		-e 's/@@LMP_HOSTNAME_NETDEVICE@@/${LMP_HOSTNAME_NETDEVICE}/' \
		${WORKDIR}/lmp-auto-hostname.service.in > lmp-auto-hostname.service

	# Force job to wait for the network interface to show up if used
	if [ "${LMP_HOSTNAME_MODE}" = "mac" -a -n "${LMP_HOSTNAME_NETDEVICE}" ]; then
		sed -i -e '/^After=.*/a After=sys-subsystem-net-devices-${LMP_HOSTNAME_NETDEVICE}.device' \
			-e '/^After=.*/a Wants=sys-subsystem-net-devices-${LMP_HOSTNAME_NETDEVICE}.device' \
			lmp-auto-hostname.service
	fi
}

do_install() {
	install -d ${D}${bindir}
	install -m 0755 ${WORKDIR}/lmp-update-hostname.sh ${D}${bindir}/lmp-update-hostname

	install -d ${D}${systemd_system_unitdir}
	install -m 0644 ${B}/lmp-auto-hostname.service ${D}${systemd_system_unitdir}
}
