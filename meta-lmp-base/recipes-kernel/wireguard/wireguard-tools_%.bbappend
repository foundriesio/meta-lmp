PACKAGES += "${PN}-wg-quick"

FILES:${PN} = " \
    ${bindir}/wg \
    ${sysconfdir} \
"
FILES:${PN}-wg-quick = " \
    ${bindir}/wg-quick \
    ${systemd_system_unitdir} \
"

RDEPENDS:${PN} = "kernel-module-wireguard"
RDEPENDS:${PN}-wg-quick = "${PN} bash"
