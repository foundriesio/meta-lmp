# Use kirkstone upstream include file
require recipes-core/ncurses/ncurses.inc
# ...and fix variables to be compatible with ncurses-6.4
LIC_FILES_CHKSUM = "file://COPYING;md5=8f2e5b99d5b6c0e6ee7cb39b992733b6;endline=27"
SRC_URI = "git://github.com/ThomasDickey/ncurses-snapshots.git;protocol=https;branch=master"


SRC_URI += "file://0001-tic-hang.patch \
           file://0002-configure-reproducible.patch \
           file://0003-gen-pkgconfig.in-Do-not-include-LDFLAGS-in-generated.patch \
           file://exit_prototype.patch \
           "
# commit id corresponds to the revision in package version
SRCREV = "27feb33ffd0039a08de54ea9bbf9d1f435e447a9"
S = "${WORKDIR}/git"
EXTRA_OECONF += "--with-abi-version=5"
UPSTREAM_CHECK_GITTAGREGEX = "(?P<pver>\d+(\.\d+)+)$"

# This is needed when using patchlevel versions like 6.1+20181013
#CVE_VERSION = "${@d.getVar("PV").split('+')[0]}.${@d.getVar("PV").split('+')[1]}"
