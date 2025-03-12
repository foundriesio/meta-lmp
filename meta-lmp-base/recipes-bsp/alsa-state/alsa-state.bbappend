FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# Install a vendor-specific asound.state file into
# /usr/lib/alsa/.
VAR_STATEDIR  = "${localstatedir}/lib/alsa"
SYS_STATEDIR = "${prefix}/lib/alsa"

do_install() {
    # Only install the init script when 'sysvinit' is in DISTRO_FEATURES.
    if ${@bb.utils.contains('DISTRO_FEATURES','sysvinit','true','false',d)}; then
        sed -i -e "s:#VARSTATEDIR#:${VAR_STATEDIR}:g" \
               -e "s:#SYSSTATEDIR#:${SYS_STATEDIR}:g" \
               ${UNPACKDIR}/alsa-state-init
        install -d ${D}${sysconfdir}/init.d
        install -m 0755 ${UNPACKDIR}/alsa-state-init ${D}${sysconfdir}/init.d/alsa-state
    fi

    install -d ${D}/${SYS_STATEDIR}
    install -d ${D}${sysconfdir}
    install -m 0644 ${UNPACKDIR}/asound.conf ${D}${sysconfdir}
    install -m 0644 ${UNPACKDIR}/*.state ${D}${SYS_STATEDIR}
}

pkg_postinst:${PN}() {
}
pkg_postinst_ontarget:${PN}() {
    if test -z "$D" && test -x ${sbindir}/alsactl; then
        if test -r ${VAR_STATEDIR}/asound.state; then
            ${sbindir}/alsactl -g -f ${VAR_STATEDIR}/asound.state restore
        else
            if test -r ${SYS_STATEDIR}/asound.state; then
                ${sbindir}/alsactl -g -f ${SYS_STATEDIR}/asound.state restore
            fi
        fi
    fi
}

FILES:alsa-states = "${SYS_STATEDIR}/*.state"
