FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://dhcpcd.sysusers \
    file://dhcpcd.tmpfiles \
"

# Disable client by default as NM should be the main driver
SYSTEMD_AUTO_ENABLE_${PN} = "disable"

EXTRA_OECONF += " --privsepuser=dhcpcd --dbdir=${localstatedir}/lib/${BPN}"

do_install_append() {
    install -Dm644 ${WORKDIR}/dhcpcd.sysusers ${D}${libdir}/sysusers.d/dhcpcd.conf
    install -Dm644 ${WORKDIR}/dhcpcd.tmpfiles ${D}${libdir}/tmpfiles.d/dhcpcd.conf
}

FILES_${PN} += "${libdir}/sysusers.d ${libdir}/tmpfiles.d"
