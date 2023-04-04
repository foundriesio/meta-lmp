# Avoid warnings with systemd
EXTRA_OECONF += "--runstatedir=/run"

do_install:append () {
    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
        (cd ${D}${localstatedir}; rmdir -v --parents lib/dbus)
    fi
}
