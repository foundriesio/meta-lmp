FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://Revert-resize-helper.service-use-conditionfirstboot-directive.patch \
    file://btsetup-hikey.service \
    file://btsetup-hikey \
"

do_install_append () {
    install -d ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/btsetup-hikey.service ${D}${systemd_unitdir}/system

    install -d ${D}${sbindir}
    install -m 0755 ${WORKDIR}/btsetup-hikey ${D}${sbindir}
}

SYSTEMD_SERVICE_${PN} += "btsetup-hikey.service"
