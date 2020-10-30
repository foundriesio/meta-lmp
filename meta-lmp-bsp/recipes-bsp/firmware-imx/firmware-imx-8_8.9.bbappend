FILES_${PN} += " \
	${nonarch_base_libdir}/firmware/imx/hdmi/hdmitxfw.bin \
	${nonarch_base_libdir}/firmware/imx/hdmi/hdmirxfw.bin \
	${nonarch_base_libdir}/firmware/imx/hdmi/dpfw.bin \
"

unset do_install[noexec]

do_install_append () {
	install -d ${D}${nonarch_base_libdir}/firmware/imx/hdmi
	install -m 0644 ${S}/firmware/hdmi/cadence/hdmitxfw.bin ${D}${nonarch_base_libdir}/firmware/imx/hdmi/
	install -m 0644 ${S}/firmware/hdmi/cadence/hdmirxfw.bin ${D}${nonarch_base_libdir}/firmware/imx/hdmi/
	install -m 0644 ${S}/firmware/hdmi/cadence/dpfw.bin ${D}${nonarch_base_libdir}/firmware/imx/hdmi/
}
