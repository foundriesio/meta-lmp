FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://tmpfiles.conf"

do_install:append() {
    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
        install -D -m 0644 ${WORKDIR}/tmpfiles.conf ${D}${nonarch_libdir}/tmpfiles.d/${PN}.conf
        rm -v -f ${D}${localstatedir}/lib/logrotate.status
        (cd ${D}${localstatedir}; rmdir -v --parents lib)
    fi
}

FILES:${PN} += "${nonarch_libdir}/tmpfiles.d/${PN}.conf"
