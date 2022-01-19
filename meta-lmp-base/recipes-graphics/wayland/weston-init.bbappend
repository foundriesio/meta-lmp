FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:lmp-wayland = " \
    file://utilities-terminal.png \
    file://background.jpg \
    file://weston.env \
    file://weston.service.patch \
    file://tmpfiles.conf \
"

FILES:${PN}:append:lmp-wayland = " \
    ${datadir}/weston \
    ${nonarch_libdir}/tmpfiles.d/weston.conf \
"

INI_UNCOMMENT_ASSIGNMENTS = " \
    ${@bb.utils.contains('DISTRO_FEATURES', 'x11 wayland', 'xwayland=true', '', d)} \
"

uncomment() {
    if ! grep -q "^#$1" $2 && ! grep -q "^$1" $2; then
        bbwarn "Commented setting '#$1' not found in file $2"
    fi
    sed -i -e 's,^#'"$1"','"$1"',g' $2
}

do_install:append:lmp-wayland() {
    install -d ${D}${datadir}/weston/backgrounds
    install -d ${D}${datadir}/weston/icon
    install -d ${D}${nonarch_libdir}/tmpfiles.d

    install -m 0644 ${WORKDIR}/utilities-terminal.png ${D}${datadir}/weston/icon/utilities-terminal.png
    install -m 0644 ${WORKDIR}/background.jpg ${D}${datadir}/weston/backgrounds/background.jpg
    install -m 0644 ${WORKDIR}/tmpfiles.conf ${D}${nonarch_libdir}/tmpfiles.d/weston.conf

    for assignment in ${INI_UNCOMMENT_ASSIGNMENTS}; do
        uncomment "$assignment" ${D}${sysconfdir}/xdg/weston/weston.ini
    done
}
