DESCRIPTION = "Tools used to push an ostree repo to and check if it is synced with OSTreeHub"
HOMEPAGE = "https://github.com/foundriesio/ostreeuploader"
SECTION = "devel"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://src/${GO_IMPORT}/LICENSE;md5=2a944942e1496af1886903d274dedb13"

GO_IMPORT = "github.com/foundriesio/ostreeuploader"
GO_IMPORT_PROTO ?= "https"
SRC_URI = "git://${GO_IMPORT};protocol=${GO_IMPORT_PROTO}"
SRCREV = "54daa6777667ab9263c65a379453b65d9a2eb19a"

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
