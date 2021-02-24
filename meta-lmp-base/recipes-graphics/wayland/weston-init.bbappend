FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
            file://weston.ini \
            file://utilities-terminal.png \
            file://background.jpg \
            "

FILES_${PN} += " ${datadir}/weston \
         ${sysconfdir}/xdg/weston/weston.ini \
         /home/root \
         "

CONFFILES_${PN} += "${sysconfdir}/xdg/weston/weston.ini"

do_install_append() {
    install -d ${D}${sysconfdir}/xdg/weston/
    install -d ${D}${datadir}/weston/backgrounds
    install -d ${D}${datadir}/weston/icon

    install -m 0644 ${WORKDIR}/weston.ini ${D}${sysconfdir}/xdg/weston
    install -m 0644 ${WORKDIR}/utilities-terminal.png ${D}${datadir}/weston/icon/utilities-terminal.png
    install -m 0644 ${WORKDIR}/background.jpg ${D}${datadir}/weston/backgrounds/background.jpg
}

