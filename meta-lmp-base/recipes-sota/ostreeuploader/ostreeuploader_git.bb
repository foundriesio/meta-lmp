DESCRIPTION = "Tools used to push an ostree repo to and check if it is synced with OSTreeHub"
HOMEPAGE = "https://github.com/foundriesio/ostreeuploader"
SECTION = "devel"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://src/${GO_IMPORT}/LICENSE;md5=6da28bf14f8fa478195ced00edf4ab7b"

GO_IMPORT = "github.com/foundriesio/ostreeuploader"
GO_IMPORT_PROTO ?= "https"
SRC_URI = "git://${GO_IMPORT};protocol=${GO_IMPORT_PROTO};branch=master"
SRCREV = "5cd2cf990d85a8459c7e9a3f156894d009485e86"

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
