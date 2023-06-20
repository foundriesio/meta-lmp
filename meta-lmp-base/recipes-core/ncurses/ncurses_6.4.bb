# Use kirkstone upstream include file
require recipes-core/ncurses/ncurses.inc
# ...and fix variables to be compatible with ncurses-6.4
LIC_FILES_CHKSUM = "file://COPYING;md5=c5a4600fdef86384c41ca33ecc70a4b8;endline=27"
SRC_URI = "git://github.com/ThomasDickey/ncurses-snapshots.git;protocol=https;branch=master"


SRC_URI += "file://0001-tic-hang.patch \
           file://0002-configure-reproducible.patch \
           file://0003-gen-pkgconfig.in-Do-not-include-LDFLAGS-in-generated.patch \
           file://exit_prototype.patch \
           "
# commit id corresponds to the revision in package version
SRCREV = "1003914e200fd622a27237abca155ce6bf2e6030"
S = "${WORKDIR}/git"
EXTRA_OECONF += "--with-abi-version=5"
UPSTREAM_CHECK_GITTAGREGEX = "(?P<pver>\d+(\.\d+)+)$"

# This is needed when using patchlevel versions like 6.1+20181013
#CVE_VERSION = "${@d.getVar("PV").split('+')[0]}.${@d.getVar("PV").split('+')[1]}"
