do_install:append() {
    if ${@bb.utils.contains('DISTRO_FEATURES', 'usrmerge', 'true', 'false', d)}; then
        mv ${D}/lib/firmware ${D}${nonarch_base_libdir}
        rmdir ${D}/lib
    fi
}
