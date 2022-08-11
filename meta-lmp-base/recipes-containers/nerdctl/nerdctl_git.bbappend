do_install() {
	install -d ${D}${bindir}
	install -m 755 ${S}/src/import/_output/nerdctl ${D}${bindir}
}

RDEPENDS:${PN} += "cni"
