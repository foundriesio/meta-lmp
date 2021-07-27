FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_lmp-wayland = " \
    file://utilities-terminal.png \
    file://background.jpg \
"

FILES_${PN}_append_lmp-wayland = " \
    ${datadir}/weston \
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

do_install_append_lmp-wayland() {
    install -d ${D}${datadir}/weston/backgrounds
    install -d ${D}${datadir}/weston/icon

    install -m 0644 ${WORKDIR}/utilities-terminal.png ${D}${datadir}/weston/icon/utilities-terminal.png
    install -m 0644 ${WORKDIR}/background.jpg ${D}${datadir}/weston/backgrounds/background.jpg

    for assignment in ${INI_UNCOMMENT_ASSIGNMENTS}; do
        uncomment "$assignment" ${D}${sysconfdir}/xdg/weston/weston.ini
    done
}
