PACKAGES += "${PN}-wg-quick"

FILES_${PN} = " \
    ${bindir}/wg \
    ${sysconfdir} \
"
FILES_${PN}-wg-quick = " \
    ${bindir}/wg-quick \
    ${systemd_system_unitdir} \
"

RDEPENDS_${PN} = "kernel-module-wireguard"
RDEPENDS_${PN}-wg-quick = "${PN} bash"
