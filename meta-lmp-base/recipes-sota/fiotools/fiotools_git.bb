DESCRIPTION = "Tool used to push ostree repositories to ostreehub"
HOMEPAGE = "https://github.com/foundriesio/ostreehub"
SECTION = "devel"
LICENSE = "CLOSED"

GO_IMPORT = "github.com/foundriesio/ostreehub"
SRC_URI = "git://${GO_IMPORT}"
SRCREV = "7439a7975f79ee924eeab680ca3fec1ce74956ef"

UPSTREAM_CHECK_COMMITS = "1"

BBCLASSEXTEND = "native"

inherit go-mod

go_do_compile() {
	cd ${B}/src/github.com/foundriesio/ostreehub
	make fiopush fiocheck
}

do_install() {
	install -d ${D}${bindir}
	install ${B}/src/github.com/foundriesio/ostreehub/bin/fiopush ${D}${bindir}
	install ${B}/src/github.com/foundriesio/ostreehub/bin/fiocheck ${D}${bindir}
}
