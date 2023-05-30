HOMEPAGE = "https://github.com/containers/skopeo"
SUMMARY = "Work with remote images registries - retrieving information, images, signing content"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://src/import/LICENSE;md5=7e611105d3e369954840a6668c438584"

DEPENDS = " \
    gpgme \
    libdevmapper \
    lvm2 \
    btrfs-tools \
    glib-2.0 \
"

inherit go

RDEPENDS:${PN} = " \
     gpgme \
     libgpg-error \
     libassuan \
"

SRC_URI = " \
    git://github.com/containers/skopeo;branch=release-1.11;protocol=https \
    file://storage.conf \
    file://registries.conf \
    file://0001-makefile-add-GOBUILDFLAGS-to-go-build-call.patch \
"

SRCREV = "d79588e6c1d2ff2053206a650adc1d30af591908"
PV = "v1.11.2+git${SRCPV}"
GO_IMPORT = "import"

S = "${WORKDIR}/git"

inherit goarch
inherit pkgconfig

# This CVE was fixed in the container image go library skopeo is using.
# See:
# https://bugzilla.redhat.com/show_bug.cgi?id=CVE-2019-10214
# https://github.com/containers/image/issues/654
CVE_CHECK_IGNORE += "CVE-2019-10214"

# This disables seccomp and apparmor, which are on by default in the
# go package. 
EXTRA_OEMAKE="BUILDTAGS=''"

do_compile() {
	export GOARCH="${TARGET_GOARCH}"

	# Setup vendor directory so that it can be used in GOPATH.
	#
	# Go looks in a src directory under any directory in GOPATH but riddler
	# uses 'vendor' instead of 'vendor/src'. We can fix this with a symlink.
	#
	# We also need to link in the ipallocator directory as that is not under
	# a src directory.
	ln -sfn . "${S}/src/import/vendor/src"
	mkdir -p "${S}/src/import/vendor/src/github.com/projectatomic/skopeo"
	ln -sfn "${S}/src/import/skopeo" "${S}/src/import/vendor/src/github.com/projectatomic/skopeo"
	ln -sfn "${S}/src/import/version" "${S}/src/import/vendor/src/github.com/projectatomic/skopeo/version"
	export GOPATH="${S}/src/import/vendor"

	# Pass the needed cflags/ldflags so that cgo
	# can find the needed headers files and libraries
	export CGO_ENABLED="1"
	export CFLAGS=""
	export LDFLAGS=""
	export CGO_CFLAGS="${TARGET_CFLAGS}"
	export CGO_LDFLAGS="${TARGET_LDFLAGS}"
	cd ${S}/src/import

	export GO111MODULE=off
	export GOBUILDFLAGS="-trimpath"
	export EXTRA_LDFLAGS="-s -w"

	oe_runmake bin/skopeo
}

do_install() {
	install -d ${D}/${sbindir}
	install -d ${D}/${sysconfdir}/containers

	install ${S}/src/import/bin/skopeo ${D}/${sbindir}/
	install ${S}/src/import/default-policy.json ${D}/${sysconfdir}/containers/policy.json

	install ${WORKDIR}/storage.conf ${D}/${sysconfdir}/containers/storage.conf
	install ${WORKDIR}/registries.conf ${D}/${sysconfdir}/containers/registries.conf
}

do_install:append:class-native() {
    create_cmdline_wrapper ${D}/${sbindir}/skopeo \
        --policy ${sysconfdir}/containers/policy.json

    create_wrapper ${D}/${sbindir}/skopeo.real \
        LD_LIBRARY_PATH=${STAGING_LIBDIR_NATIVE}
}

do_install:append:class-nativesdk() {
    create_cmdline_wrapper ${D}/${sbindir}/skopeo \
        --policy ${sysconfdir}/containers/policy.json
}

INSANE_SKIP:${PN} += "ldflags already-stripped"

BBCLASSEXTEND = "native nativesdk"
