SUMMARY = "A tiny but valid init for containers (used as docker-init)"
HOMEPAGE = "https://github.com/krallin/tini"
DESCRIPTION = "Tini is a simple init that spawns a single child and \
 wait for it to exit all the while reaping zombies and performing signal \
 forwarding. Docker uses tini as the default container init process."
SECTION = "devel"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=ffc9091894702bc5dcf4cc0085561ef5"

SRCREV = "949e6facb77383876aeff8a6944dde66b3089574"
SRC_URI = "\
	git://github.com/krallin/tini.git \
	file://dont_strip_by_default.patch \
	"

S = "${WORKDIR}/git"

inherit cmake

OECMAKE_TARGET_COMPILE = "tini-static"

do_install() {
	mkdir -p ${D}/${bindir}
	cp ${B}/tini-static ${D}/${bindir}/docker-init
}
