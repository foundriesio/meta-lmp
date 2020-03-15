DESCRIPTION = "Make your Docker Compose applications reusable, and share them on Docker Hub"
HOMEPAGE = "https://github.com/docker/app"
SECTION = "devel"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://src/${GO_IMPORT}/LICENSE;md5=4859e97a9c7780e77972d989f0823f28"

GO_IMPORT = "github.com/docker/app"
SRC_URI = "git://${GO_IMPORT}"
SRCREV = "9f9c6680050949f4298a035314fec460d647f709"

UPSTREAM_CHECK_COMMITS = "1"
PV = "v0.6.0"

inherit go goarch

do_compile() {
	cd ${S}/src/${GO_IMPORT}
	BUILD_TAG=`git describe --always --abbrev=10`
	BUILD_COMMIT=`git rev-parse --short HEAD`
	DOCKER_APP_LDFLAGS="-X ${GO_IMPORT}/internal.GitCommit=${BUILD_COMMIT} \
		-X ${GO_IMPORT}/internal.Version=${BUILD_TAG} \
		-X ${GO_IMPORT}/internal.Experimental=off"
	mkdir -p ${B}/${GO_BUILD_BINDIR}
	${GO} build -ldflags="${DOCKER_APP_LDFLAGS}" -o ${B}/${GO_BUILD_BINDIR}/docker-app ./cmd/docker-app
}

RDEPENDS_${PN}-dev += "bash"
