FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = "\
	file://cli-config-support-default-system-config.patch \
	"

do_install() {
	install -d ${D}${bindir}
	install -m 755 ${S}/src/import/_output/nerdctl ${D}${bindir}
}
