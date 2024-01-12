DESCRIPTION = "A CLI utility to manage compose apps"

SECTION = "devel"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://src/${GO_IMPORT}/LICENSE;md5=2a944942e1496af1886903d274dedb13"

GO_IMPORT = "github.com/foundriesio/composeapp"
GO_IMPORT_PROTO ?= "https"
SRC_URI = "git://${GO_IMPORT};protocol=${GO_IMPORT_PROTO};branch=main"
SRCREV = "5419dab59df5b546f78269570bb47bb871654b8f"
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
