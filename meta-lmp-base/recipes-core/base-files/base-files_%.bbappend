FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://tmpfiles.conf"

do_install:append () {
    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
        install -D -m 0644 ${WORKDIR}/tmpfiles.conf ${D}${nonarch_libdir}/tmpfiles.d/${PN}.conf
    fi
    # Get rid of the /dev/root entry in fstab to avoid errors from
    # systemd-remount-fs
    if ${@bb.utils.contains('DISTRO_FEATURES', 'cfs', 'true', 'false', d)}; then
        sed -i -e '\#^ */dev/root#d' ${D}${sysconfdir}/fstab
    fi

}

FILES:${PN} += "${nonarch_libdir}/tmpfiles.d/${PN}.conf"

BASEFILESISSUEINSTALL = ""
