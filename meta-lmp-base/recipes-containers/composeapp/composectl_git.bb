DESCRIPTION = "A CLI utility to manage compose apps"
HOMEPAGE = "https://github.com/foundriesio/composeapp"
SECTION = "devel"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://src/${GO_IMPORT}/LICENSE;md5=504a5c2455c8bb2fc5b7667833ab1a68"

GO_IMPORT = "github.com/foundriesio/composeapp"
GO_IMPORT_PROTO ?= "https"
SRCBRANCH = "v95"
SRCREV = "862e6bee1d6596a80855c43c19f0655870e2d505"
SRC_URI = "git://${GO_IMPORT};protocol=${GO_IMPORT_PROTO};branch=${SRCBRANCH}"
UPSTREAM_CHECK_COMMITS = "1"

inherit go-mod

# FIXME: Turning off the dynamic linkage is not needed with certain golang versions, e.g. 1.25.3
GO_DYNLINK:forcevariable = ""
GO_INSTALL = "${GO_IMPORT}/cmd/composectl"
GO_EXTRA_LDFLAGS = "\
    -X '${GO_IMPORT}/cmd/composectl/cmd.storeRoot=/var/sota/reset-apps' \
    -X '${GO_IMPORT}/cmd/composectl/cmd.composeRoot=/var/sota/compose-apps' \
    -X '${GO_IMPORT}/cmd/composectl/cmd.baseSystemConfig=/usr/lib/docker' \
    -X '${GO_IMPORT}/cmd/composectl/cmd.commit=${SRCREV}' \
"
do_install:append() {
    cd ${D}/${bindir}
    ln -sf composectl aklite-apps
}
