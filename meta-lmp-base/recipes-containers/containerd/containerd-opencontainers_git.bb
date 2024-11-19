HOMEPAGE = "https://github.com/docker/containerd"
SUMMARY = "containerd is a daemon to control runC"
DESCRIPTION = "containerd is a daemon to control runC, built for performance and density. \
               containerd leverages runC's advanced features such as seccomp and user namespace \
               support as well as checkpoint and restore for cloning and live migration of containers."


SRCREV = "7c3aca7a610df76212171d200ca3811ff6096eb8"
SRC_URI = "git://github.com/containerd/containerd;branch=release/1.7;protocol=https;destsuffix=git/src/github.com/containerd/containerd \
           file://0001-Makefile-allow-GO_BUILD_FLAGS-to-be-externally-speci.patch \
           file://0001-build-don-t-use-gcflags-to-define-trimpath.patch \
          "

# Apache-2.0 for containerd
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=1269f40c0d099c21a871163984590d89"

CONTAINERD_VERSION = "v1.7.13"
CVE_VERSION = "1.7.13"

# EXTRA_OEMAKE += "GODEBUG=1"

PROVIDES += "virtual/containerd"
RPROVIDES:${PN} = "virtual-containerd"

S = "${WORKDIR}/git/src/github.com/containerd/containerd"

PV = "${CONTAINERD_VERSION}+git"

inherit go
inherit goarch

GO_IMPORT = "import"

CONTAINERD_PKG="github.com/containerd/containerd"

INSANE_SKIP:${PN} += "ldflags"

do_configure[noexec] = "1"

do_compile() {
    export GOARCH="${TARGET_GOARCH}"

    export GOPATH="${S}/src/import/.gopath:${S}/src/import/vendor:${STAGING_DIR_TARGET}/${prefix}/local/go:${WORKDIR}/git/"
    export GOROOT="${STAGING_DIR_NATIVE}/${nonarch_libdir}/${HOST_SYS}/go"

    # Pass the needed cflags/ldflags so that cgo
    # can find the needed headers files and libraries
    export CGO_ENABLED="1"
    export CGO_CFLAGS="${CFLAGS} --sysroot=${STAGING_DIR_TARGET}"
    export CGO_LDFLAGS="${LDFLAGS} --sysroot=${STAGING_DIR_TARGET}"
    export BUILDTAGS="no_btrfs static_build netgo"
    export CFLAGS="${CFLAGS}"
    export LDFLAGS="${LDFLAGS}"
    export SHIM_CGO_ENABLED="${CGO_ENABLED}"
    # fixes:
    # cannot find package runtime/cgo (using -importcfg)
    #        ... recipe-sysroot-native/usr/lib/aarch64-poky-linux/go/pkg/tool/linux_amd64/link:
    #        cannot open file : open : no such file or directory
    export GO_BUILD_FLAGS="-trimpath -a -pkgdir dontusecurrentpkgs"
    export GO111MODULE=off

    cd ${S}

    oe_runmake binaries
}

inherit systemd
SYSTEMD_PACKAGES = "${@bb.utils.contains('DISTRO_FEATURES','systemd','${PN}','',d)}"
SYSTEMD_SERVICE:${PN} = "${@bb.utils.contains('DISTRO_FEATURES','systemd','containerd.service','',d)}"

do_install() {
	mkdir -p ${D}/${bindir}

	cp ${S}/bin/containerd ${D}/${bindir}/containerd
	cp ${S}/bin/containerd-shim ${D}/${bindir}/containerd-shim
	cp ${S}/bin/containerd-shim-runc-v1 ${D}/${bindir}/containerd-shim-runc-v1
	cp ${S}/bin/containerd-shim-runc-v2 ${D}/${bindir}/containerd-shim-runc-v2
	cp ${S}/bin/ctr ${D}/${bindir}/containerd-ctr

	ln -sf containerd ${D}/${bindir}/docker-containerd
	ln -sf containerd-shim ${D}/${bindir}/docker-containerd-shim
	ln -sf containerd-ctr ${D}/${bindir}/docker-containerd-ctr

	ln -sf containerd-ctr ${D}/${bindir}/ctr

	if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
		install -d ${D}${systemd_unitdir}/system
		install -m 644 ${S}/containerd.service ${D}/${systemd_unitdir}/system
	        # adjust from /usr/local/bin to /usr/bin/
		sed -e "s:/usr/local/bin/containerd:${bindir}/containerd:g" -i ${D}/${systemd_unitdir}/system/containerd.service
	fi
}

FILES:${PN} += "${systemd_system_unitdir}/*"

INSANE_SKIP:${PN} += "ldflags already-stripped"

COMPATIBLE_HOST = "^(?!(qemu)?mips).*"

RDEPENDS:${BPN} += " virtual-runc"

CVE_PRODUCT = "containerd"
