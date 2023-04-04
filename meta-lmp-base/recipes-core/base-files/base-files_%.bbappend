FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://tmpfiles.conf"

do_install:append () {
    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
        install -D -m 0644 ${WORKDIR}/tmpfiles.conf ${D}${nonarch_libdir}/tmpfiles.d/${PN}.conf
        (
            # Remove /var stuff
            cd ${D}${localstatedir};
            rmdir -v backups spool local;
            rmdir -v --parents lib/misc;
            # there may be another folder volatile/log, so this
            # command may fail and it's ok
            rmdir -v volatile/tmp;
            rmdir -v ${@'volatile/' if oe.types.boolean('${VOLATILE_LOG_DIR}') else ''}log;
            # symlinks
            rm -v run lock;
        )
    fi
}

FILES:${PN} += "${nonarch_libdir}/tmpfiles.d/${PN}.conf"
