FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# Try to restore sound configuration from /usr/lib/alsa/asound.state
# if /var/lib/alsa/asound.state is unavailable.
SRC_URI += "\
    file://0001-alsactl-add-fallback-for-restoring-from-asound.state.patch \
    file://tmpfiles.conf \
"
EXTRA_OECONF:append = " --with-init-asound-state-dir=${prefix}/lib/alsa"

do_install:append() {
    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
        install -D -m 0644 ${WORKDIR}/tmpfiles.conf ${D}${nonarch_libdir}/tmpfiles.d/alsa_utils.conf
        (cd ${D}; vardir=${localstatedir#*/}; rmdir -v --parents ${vardir}/lib/alsa)
    fi
}

FILES:alsa-utils-alsactl += "${@bb.utils.contains('DISTRO_FEATURES', 'systemd', '${nonarch_libdir}/tmpfiles.d/alsa_utils.conf', '', d)}"
