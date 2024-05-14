HOMEPAGE = "https://github.com/docker/compose"
SUMMARY = "Define and run multi-container applications with Docker"
DESCRIPTION = "Docker Compose is a tool for running multi-container \
 applications on Docker defined using the Compose file format."
SECTION = "devel"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://src/${GO_IMPORT}/LICENSE;md5=175792518e4ac015ab6696d16c4f607e"

SRC_URI = "\
	git://github.com/docker/compose.git;branch=main;protocol=https;name=compose \
	git://github.com/docker/cli.git;branch=24.0;protocol=https;name=cli;destsuffix=${S}/src/github.com/docker/cli \
	"

SRCREV_compose = "d6f842b042d2f2926901305336527b3eaadf067a"
SRCREV_cli = "ced099660009713e0e845eeb754e6050dbaa45d0"
SRCREV_FORMAT = "compose_cli"

UPSTREAM_CHECK_COMMITS = "1"

GO_IMPORT = "github.com/docker/compose/v2"

inherit go-mod

GO_EXTRA_LDFLAGS = "-w -X ${GO_IMPORT}/internal.Version=${PV}"

go_do_compile() {
	export TMPDIR="${GOTMPDIR}"
	mkdir -p ${B}/cli-plugins/bin
	${GO} mod download -modcacherw
	cp -f ${S}/src/github.com/docker/cli/cli/config/config.go ${B}/.mod/github.com/docker/cli@v24.0.5+incompatible/cli/config/config.go
	${GO} build ${GOBUILDFLAGS} -o ${B}/cli-plugins/bin/docker-compose ./cmd
}

go_do_install:append() {
	install -d ${D}${libdir}/docker/cli-plugins
	install -m 755 ${B}/cli-plugins/bin/docker-compose ${D}${libdir}/docker/cli-plugins
}

FILES:${PN} += "${libdir}/docker/cli-plugins"

RDEPENDS:${PN} += "docker"
