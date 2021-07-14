DESCRIPTION = "Tools used to push an ostree repo to and check if it is synced with OSTreeHub"
HOMEPAGE = "https://github.com/foundriesio/ostreeuploader"
SECTION = "devel"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://src/${GO_IMPORT}/LICENSE;md5=2a944942e1496af1886903d274dedb13"

GO_IMPORT = "github.com/foundriesio/ostreeuploader"
SRC_URI = "git://${GO_IMPORT}"
SRCREV = "b616f3ecad261beef036f9c300bf8a9f9f23b8c5"

UPSTREAM_CHECK_COMMITS = "1"

BBCLASSEXTEND = "native"

inherit go-mod

go_do_compile() {
	cd ${B}/src/github.com/foundriesio/ostreeuploader
	make
}

do_install() {
	install -d ${D}${bindir}
	install -m 0755 ${B}/src/github.com/foundriesio/ostreeuploader/bin/fiopush ${D}${bindir}
	install -m 0755 ${B}/src/github.com/foundriesio/ostreeuploader/bin/fiocheck ${D}${bindir}
}
