DESCRIPTION = "A tool to check and fix an image&layer store of the docker daemon"
HOMEPAGE = "https://github.com/foundriesio/fio-docker-fsck"
SECTION = "devel"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://src/${GO_IMPORT}/LICENSE;md5=86d3f3a95c324c9479bd8986968f4327"

GO_IMPORT = "github.com/foundriesio/fio-docker-fsck"
SRC_URI = " \
	git://${GO_IMPORT};branch=${SRCBRANCH} \
	file://fio-docker-fsck.service \
"
SRCREV = "337b94e6f828adb55eab18499b472661d7607dfa"
SRCBRANCH = "main"

UPSTREAM_CHECK_COMMITS = "1"

SYSTEMD_SERVICE_${PN} = "fio-docker-fsck.service"

inherit go-mod systemd

go_do_compile() {
	cd ${B}/src/github.com/foundriesio/fio-docker-fsck
	make
}

do_install() {
	install -d ${D}${bindir}
	install -m 0755 ${B}/src/github.com/foundriesio/fio-docker-fsck/bin/fio-docker-fsck ${D}${bindir}
	install -d ${D}${systemd_system_unitdir}
	install -m 0644 ${WORKDIR}/fio-docker-fsck.service ${D}${systemd_system_unitdir}/
}
