FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_lmp-wayland = " \
    file://utilities-terminal.png \
    file://background.jpg \
"

FILES_${PN}_append_lmp-wayland = " \
    ${datadir}/weston \
"

do_install_append_lmp-wayland() {
    install -d ${D}${datadir}/weston/backgrounds
    install -d ${D}${datadir}/weston/icon

    install -m 0644 ${WORKDIR}/utilities-terminal.png ${D}${datadir}/weston/icon/utilities-terminal.png
    install -m 0644 ${WORKDIR}/background.jpg ${D}${datadir}/weston/backgrounds/background.jpg
}
