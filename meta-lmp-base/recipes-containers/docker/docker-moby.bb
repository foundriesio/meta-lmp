HOMEPAGE = "http://www.docker.com"
SUMMARY = "Linux container runtime"
DESCRIPTION = "Linux container runtime \
 Docker complements kernel namespacing with a high-level API which \
 operates at the process level. It runs unix processes with strong \
 guarantees of isolation and repeatability across servers. \
 . \
 Docker is a great building block for automating distributed systems: \
 large-scale web deployments, database clusters, continuous deployment \
 systems, private PaaS, service-oriented architectures, etc. \
 . \
 This package contains the daemon and client, which are \
 officially supported on x86_64 and arm hosts. \
 Other architectures are considered experimental. \
 . \
 Also, note that kernel version 3.10 or above is required for proper \
 operation of the daemon process, and that any lower versions may have \
 subtle and/or glaring issues. \
 "

# Notes:
#   - This docker variant uses moby and the other individually maintained
#     upstream variants for SRCREVs
#   - It is a true community / upstream tracking build, and is not a
#     docker curated set of commits or additions
#   - The version number on this package tracks the versions assigned to
#     the curated docker-ce repository. This allows compatibility and
#     functional equivalence, while allowing new features to be more
#     easily added.
#   - This could be called "docker-moby" or just "moby" in the future, but
#     that would require the creation of a virtual/docker dependency, which
#     is possible, but overkill at the moment (while we wait for the upstream
#     to stop changing).
#   - The common components of this recipe and docker-ce do need to be moved
#     to a docker.inc recipe

# commits based on v20.10.5
SRCREV_moby = "363e9a88a11be517d9e8c65c998ff56f774eb4dc"
SRCREV_libnetwork = "fa125a3512ee0f6187721c88582bf8c4378bd4d7"
SRCREV_cli = "55c4c88966a912ddb365e2d73a4969e700fc458f"
SRC_URI = "\
	git://github.com/moby/moby.git;branch=20.10;name=moby \
	git://github.com/moby/libnetwork.git;branch=master;name=libnetwork;destsuffix=git/libnetwork \
	git://github.com/docker/cli;branch=20.10;name=cli;destsuffix=git/cli \
	file://0001-libnetwork-use-GO-instead-of-go.patch \
	file://0001-cli-use-go-cross-compiler.patch \
	file://0001-dynbinary-use-go-cross-compiler.patch \
	file://dockerd-daemon-use-default-system-config-when-none-i.patch \
	file://cli-config-support-default-system-config.patch \
	file://increase_containerd_timeouts.patch \
	file://dockerd-daemon-reload-image-store-on-a-hup-signal.patch \
	"

require recipes-containers/docker/docker.inc
require docker-lmp.inc

# Apache-2.0 for docker
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://src/import/LICENSE;md5=4859e97a9c7780e77972d989f0823f28"

GO_IMPORT = "import"

S = "${WORKDIR}/git"

DOCKER_VERSION = "20.10.5"
PV = "${DOCKER_VERSION}"

PACKAGES =+ "${PN}-contrib"

DOCKER_PKG="github.com/docker/docker"
# in order to exclude devicemapper and btrfs - https://github.com/docker/docker/issues/14056
BUILD_TAGS = "exclude_graphdriver_btrfs exclude_graphdriver_devicemapper"

inherit go
inherit goarch

do_configure[noexec] = "1"

do_compile() {
	# Set GOPATH. See 'PACKAGERS.md'. Don't rely on
	# docker to download its dependencies but rather
	# use dependencies packaged independently.
	cd ${S}/src/import
	rm -rf .gopath
	mkdir -p .gopath/src/"$(dirname "${DOCKER_PKG}")"
	ln -sf ../../../.. .gopath/src/"${DOCKER_PKG}"

	mkdir -p .gopath/src/github.com/docker
	ln -sf ${WORKDIR}/git/libnetwork .gopath/src/github.com/docker/libnetwork
	ln -sf ${WORKDIR}/git/cli .gopath/src/github.com/docker/cli

	export GOPATH="${S}/src/import/.gopath:${S}/src/import/vendor:${STAGING_DIR_TARGET}/${prefix}/local/go"
	export GOROOT="${STAGING_DIR_NATIVE}/${nonarch_libdir}/${HOST_SYS}/go"

	# Pass the needed cflags/ldflags so that cgo
	# can find the needed headers files and libraries
	export GOARCH=${TARGET_GOARCH}
	export CGO_ENABLED="1"
	export CGO_CFLAGS="${CFLAGS} --sysroot=${STAGING_DIR_TARGET}"
	export CGO_LDFLAGS="${LDFLAGS} --sysroot=${STAGING_DIR_TARGET}"
	export DOCKER_BUILDTAGS='${BUILD_TAGS} ${PACKAGECONFIG_CONFARGS}'
	export GO111MODULE=off

	export DISABLE_WARN_OUTSIDE_CONTAINER=1

	cd ${S}/src/import/

	# this is the unsupported built structure
	# that doesn't rely on an existing docker
	# to build this:
	VERSION="${DOCKER_VERSION}" DOCKER_GITCOMMIT="${SRCREV_moby}" ./hack/make.sh dynbinary

        # build the cli
	cd ${S}/src/import/.gopath/src/github.com/docker/cli
	export CFLAGS=""
	export LDFLAGS=""
	export DOCKER_VERSION=${DOCKER_VERSION}
	VERSION="${DOCKER_VERSION}" DOCKER_GITCOMMIT="${SRCREV_moby}" make dynbinary

	# build the proxy
	cd ${S}/src/import/.gopath/src/github.com/docker/libnetwork
	oe_runmake cross-local
}

do_install() {
	mkdir -p ${D}/${bindir}
	cp ${WORKDIR}/git/cli/build/docker ${D}/${bindir}/docker
	cp ${S}/src/import/bundles/dynbinary-daemon/dockerd ${D}/${bindir}/dockerd
	cp ${WORKDIR}/git/libnetwork/bin/docker-proxy* ${D}/${bindir}/docker-proxy

	if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
		install -d ${D}${systemd_unitdir}/system
		install -m 644 ${S}/src/import/contrib/init/systemd/docker.* ${D}/${systemd_unitdir}/system
		# replaces one copied from above with one that uses the local registry for a mirror
		install -m 644 ${S}/src/import/contrib/init/systemd/docker.service ${D}/${systemd_unitdir}/system
		rm -f ${D}/${systemd_unitdir}/system/docker.service.rpm
	fi
	# TLS key that docker creates at run-time if not found is what resides here
	if ${@bb.utils.contains('PACKAGECONFIG','transient-config','true','false',d)}; then
		install -d ${D}${sysconfdir}
		ln -s ..${localstatedir}/run/docker ${D}${sysconfdir}/docker
	else
		install -d ${D}${sysconfdir}/docker
	fi

	mkdir -p ${D}${datadir}/docker/
	install -m 0755 ${S}/src/import/contrib/check-config.sh ${D}${datadir}/docker/
}

FILES_${PN} += "${systemd_unitdir}/system/* ${sysconfdir}/docker"

FILES_${PN}-contrib += "${datadir}/docker/check-config.sh"
RDEPENDS_${PN}-contrib += "bash"
