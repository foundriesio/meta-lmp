DESCRIPTION = "A tool to check and fix an image&layer store of the docker daemon"
HOMEPAGE = "https://github.com/foundriesio/fio-docker-fsck"
SECTION = "devel"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://src/${GO_IMPORT}/LICENSE;md5=6da28bf14f8fa478195ced00edf4ab7b"

GO_IMPORT = "github.com/foundriesio/fio-docker-fsck"
GO_IMPORT_PROTO ?= "https"
SRC_URI = " \
	git://${GO_IMPORT};protocol=${GO_IMPORT_PROTO};branch=${SRCBRANCH} \
	file://fio-docker-fsck.service \
"
SRCREV = "c939707c8f424cfd02c8d3c42605ffdb3439d653"
SRCBRANCH = "main"

UPSTREAM_CHECK_COMMITS = "1"

SYSTEMD_SERVICE:${PN} = "fio-docker-fsck.service"

inherit go-mod systemd

do_install:append() {
	install -d ${D}${systemd_system_unitdir}
	install -m 0644 ${WORKDIR}/fio-docker-fsck.service ${D}${systemd_system_unitdir}/
}
