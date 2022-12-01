FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:imx-generic-bsp = " \
	file://boot-common-imx.cmd.in \
"

do_compile:prepend:imx-generic-bsp() {
	sed -e '/@@INCLUDE_COMMON_IMX@@/ {' -e 'r ${S}/boot-common-imx.cmd.in' -e 'd' -e '}' \
			"${S}/boot.cmd" > boot.cmd.in
}
