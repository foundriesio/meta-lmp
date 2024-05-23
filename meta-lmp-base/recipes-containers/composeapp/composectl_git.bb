DESCRIPTION = "A CLI utility to manage compose apps"
HOMEPAGE = "https://github.com/foundriesio/composeapp"
SECTION = "devel"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://src/${GO_IMPORT}/LICENSE;md5=504a5c2455c8bb2fc5b7667833ab1a68"

GO_IMPORT = "github.com/foundriesio/composeapp"
GO_IMPORT_PROTO ?= "https"
SRC_URI = "git://${GO_IMPORT};protocol=${GO_IMPORT_PROTO};branch=main"
SRCREV = "1b6f1f2d8f55d40fef10c8ddfef224a9a58caa27"
UPSTREAM_CHECK_COMMITS = "1"

inherit go-mod

GO_INSTALL = "${GO_IMPORT}/cmd/composectl"
GO_EXTRA_LDFLAGS = "\
    -X '${GO_IMPORT}/cmd/composectl/cmd.storeRoot=/var/sota/reset-apps' \
    -X '${GO_IMPORT}/cmd/composectl/cmd.composeRoot=/var/sota/compose-apps' \
    -X '${GO_IMPORT}/cmd/composectl/cmd.overrideConfigDir=/usr/lib/docker' \
"
do_install:append() {
    cd ${D}/${bindir}
    ln -sf composectl aklite-apps
}
