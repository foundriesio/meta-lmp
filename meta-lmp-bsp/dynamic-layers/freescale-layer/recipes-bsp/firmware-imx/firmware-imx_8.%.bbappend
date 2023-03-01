do_install:append() {
    install -m 0644 ${S}/firmware/sdma/sdma-imx6q.bin ${D}${nonarch_base_libdir}/firmware/imx/sdma
    install -m 0644 ${S}/firmware/sdma/sdma-imx7d.bin ${D}${nonarch_base_libdir}/firmware/imx/sdma
}
