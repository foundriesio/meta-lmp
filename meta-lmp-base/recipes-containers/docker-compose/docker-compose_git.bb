HOMEPAGE = "https://github.com/docker/compose"
SUMMARY =  "Multi-container orchestration for Docker"
DESCRIPTION = "Docker compose v2"

DEPENDS = " \
    go-md2man \
"

SRCREV_compose = "85d6770b7fb6e2b38234cc9219f59049e42d6924"
SRCREV_FORMAT = "compose"

SRC_URI = "git://github.com/docker/compose;branch=main;name=compose;protocol=https;destsuffix=${GO_SRCURI_DESTSUFFIX}"

# GO_MOD_FETCH_MODE: "vcs" (all git://) or "hybrid" (gomod:// + git://)
GO_MOD_FETCH_MODE ?= "hybrid"

# VCS mode: all modules via git://
include ${@ "go-mod-git.inc" if d.getVar("GO_MOD_FETCH_MODE") == "vcs" else ""}
include ${@ "go-mod-cache.inc" if d.getVar("GO_MOD_FETCH_MODE") == "vcs" else ""}

# Hybrid mode: gomod:// for most, git:// for selected
include ${@ "go-mod-hybrid-gomod.inc" if d.getVar("GO_MOD_FETCH_MODE") == "hybrid" else ""}
include ${@ "go-mod-hybrid-git.inc" if d.getVar("GO_MOD_FETCH_MODE") == "hybrid" else ""}
include ${@ "go-mod-hybrid-cache.inc" if d.getVar("GO_MOD_FETCH_MODE") == "hybrid" else ""}

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://src/import/LICENSE;md5=175792518e4ac015ab6696d16c4f607e"

GO_IMPORT = "import"

PV = "v5.1.0"

COMPOSE_PKG = "github.com/docker/compose/v2"

# go-mod-discovery configuration
GO_MOD_DISCOVERY_BUILD_TARGET = "./cmd"
GO_MOD_DISCOVERY_GIT_REPO = "https://github.com/docker/compose.git"
GO_MOD_DISCOVERY_GIT_REF = "${SRCREV_compose}"

inherit go goarch
inherit pkgconfig
inherit go-mod-discovery

COMPATIBLE_HOST = "^(?!mips).*"

do_configure[noexec] = "1"

PACKAGECONFIG ?= "docker-plugin"
PACKAGECONFIG[docker-plugin] = ",,,docker"

do_compile() {
	cd ${S}/src/import

	# GOMODCACHE, GOPROXY, GOSUMDB, GOTOOLCHAIN are set by go-mod-vcs.bbclass
	export GOPATH="${S}/src/import/.gopath:${STAGING_DIR_TARGET}/${prefix}/local/go"
	export CGO_ENABLED="1"

	# Pass the needed cflags/ldflags so that cgo
	# can find the needed headers files and libraries
	export GOARCH=${TARGET_GOARCH}
	export CGO_CFLAGS="${CFLAGS}"
	export CGO_LDFLAGS="${LDFLAGS}"

	GO_LDFLAGS="-s -w -X internal.Version=${PV} -X ${COMPOSE_PKG}/internal.Version=${PV}"
	GO_BUILDTAGS=""
	mkdir -p ./bin
	${GO} build ${GOBUILDFLAGS} -tags "$GO_BUILDTAGS" -ldflags "$GO_LDFLAGS" -o ./bin/docker-compose ./cmd
}

do_install() {
	if ${@bb.utils.contains('PACKAGECONFIG', 'docker-plugin', 'true', 'false', d)}; then
		install -d ${D}${nonarch_libdir}/docker/cli-plugins
		install -m 755 ${S}/src/import/bin/docker-compose ${D}${nonarch_libdir}/docker/cli-plugins
	else
		install -d ${D}${bindir}
		install -m 755 ${S}/src/import/bin/docker-compose ${D}${bindir}
	fi
}


FILES:${PN} += " ${nonarch_libdir}/docker/cli-plugins/"

INHIBIT_PACKAGE_STRIP = "1"
INSANE_SKIP:${PN} += "ldflags already-stripped"

# the AWS dependency is 8GB, try and control the
# size of the clones
BB_GIT_SHALLOW = "1"
