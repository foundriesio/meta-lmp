require wireguard.inc

SRCREV = "7a321ce808ef9cec1f45cce92befcc9e170d3aa9"
SRC_URI = "git://git.zx2c4.com/wireguard-tools"

inherit bash-completion systemd pkgconfig

DEPENDS += "libmnl"

do_install () {
    oe_runmake DESTDIR="${D}" PREFIX="${prefix}" SYSCONFDIR="${sysconfdir}" \
        SYSTEMDUNITDIR="${systemd_unitdir}" \
        WITH_SYSTEMDUNITS=${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'yes', '', d)} \
        WITH_BASHCOMPLETION=yes \
        WITH_WGQUICK=yes \
        install
}

PACKAGES += "${PN}-wg-quick"

FILES_${PN} = " \
    ${bindir}/wg \
    ${sysconfdir} \
"
FILES_${PN}-wg-quick = " \
    ${bindir}/wg-quick \
    ${systemd_unitdir} \
"

RDEPENDS_${PN} = "kernel-module-wireguard"
RDEPENDS_${PN}-wg-quick = "${PN} bash"
