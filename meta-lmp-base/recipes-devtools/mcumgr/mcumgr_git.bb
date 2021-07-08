DESCRIPTION = "Management library for 32-bit MCUs"
HOMEPAGE = "https://github.com/apache/mynewt-mcumgr"
SECTION = "devel"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

GO_IMPORT = "github.com/apache/mynewt-mcumgr-cli/mcumgr"
SRC_URI = "git://github.com/apache/mynewt-mcumgr-cli"
SRCREV = "0ba791a8d336bc751598be36099998439184b033"

UPSTREAM_CHECK_COMMITS = "1"
PV = "v0.0.1+git"

inherit go goarch godep

# OE build default do_compile recipe is creating oddly broken binary
# To fix this, let's use the same as manual build steps
# NOTE: The binary is much larger than default recipe
do_compile() {
	cd ${S}/src/${GO_IMPORT}/mcumgr
	mkdir -p ${B}/${GO_BUILD_BINDIR}
	${GO} build -o ${B}/${GO_BUILD_BINDIR}/mcumgr mcumgr.go
	chmod u+w -R ${B}
}

RDEPENDS_${PN}-dev += "bash"
RDEPENDS_${PN}-staticdev += "bash"
