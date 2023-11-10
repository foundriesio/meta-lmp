# Upstream-status: backport only for kirkstone [remove for scarthgap]
# not supposed to be upstream on kirkstone
# merged on master/scarthgap
# https://github.com/openembedded/meta-openembedded/commit/865411fbde1f3489e77ad186e669b5c315485ce1

require recipes-kernel/wireguard/wireguard.inc

SRCREV = "3ba6527130c502144e7388b900138bca6260f4e8"
SRC_URI = "git://git.zx2c4.com/wireguard-tools;branch=master"

inherit bash-completion systemd pkgconfig

DEPENDS += "libmnl"

do_install () {
    oe_runmake DESTDIR="${D}" PREFIX="${prefix}" SYSCONFDIR="${sysconfdir}" \
        SYSTEMDUNITDIR="${systemd_system_unitdir}" \
        WITH_SYSTEMDUNITS=${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'yes', '', d)} \
        ${PACKAGECONFIG_CONFARGS} \
        install
}

PACKAGECONFIG ??= "bash-completion wg-quick"

PACKAGECONFIG[bash-completion] = "WITH_BASHCOMPLETION=yes,WITH_BASHCOMPLETION=no,,bash,,"
PACKAGECONFIG[wg-quick]        = "WITH_WGQUICK=yes,WITH_WGQUICK=no,,bash,,"

FILES:${PN} = " \
    ${bindir}/wg \
    ${sysconfdir} \
    ${bindir}/wg-quick \
    ${systemd_system_unitdir} \
"

RRECOMMENDS:${PN} = " \
    kernel-module-wireguard \
    "
