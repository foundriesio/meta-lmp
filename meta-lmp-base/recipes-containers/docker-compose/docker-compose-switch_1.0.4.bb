HOMEPAGE = "https://github.com/docker/compose-switch"
SUMMARY = "Compose Switch is a replacement to the Compose V1 \
 docker-compose (python) executable. It translates the command \
 line into Compose V2 docker compose then run the latter."
SECTION = "devel"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://src/${GO_IMPORT}/LICENSE;md5=3b83ef96387f14655fc854ddc3c6bd57"

SRC_URI = "git://github.com/docker/compose-switch.git;branch=master;protocol=https"
SRCREV = "2b8c6e31c6d1b172cd4b94f316a849558d755bcb"

UPSTREAM_CHECK_COMMITS = "1"

GO_IMPORT = "github.com/docker/compose-switch"

inherit go-mod update-alternatives

GO_EXTRA_LDFLAGS = "-w -X ${GO_IMPORT}/internal.Version=${PV}"

go_do_compile() {
	export TMPDIR="${GOTMPDIR}"
	mkdir -p ${B}/${GO_BUILD_BINDIR}
	${GO} build ${GOBUILDFLAGS} -o ${B}/${GO_BUILD_BINDIR}/docker-compose ./main.go
}

ALTERNATIVE:${PN} = "docker-compose"
ALTERNATIVE_PRIORITY = "100"
ALTERNATIVE_LINK_NAME[docker-compose] = "${base_bindir}/docker-compose"

RDEPENDS:${PN} += "docker-compose"
