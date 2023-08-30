DESCRIPTION = "One-Time-Programmable (OTP) fusing tool"
HOMEPAGE = "https://github.com/f-secure-foundry/crucible"
SECTION = "devel"
LICENSE = "GPL-3.0-only"
LIC_FILES_CHKSUM = "file://src/${GO_IMPORT}/LICENSE;md5=f10c6a44a73c48e5edb8daddd89517ba"

GO_IMPORT = "github.com/f-secure-foundry/crucible"
GO_IMPORT_PROTO ?= "https"
SRC_URI = "git://${GO_IMPORT};protocol=${GO_IMPORT_PROTO};branch=master"
SRCREV = "b84eb54532b969fed3025fb291fd83eafa0417e3"

PV = "v2021.05.03+git"

UPSTREAM_CHECK_COMMITS = "1"

inherit go-mod dos2unix

do_install:append() {
    install -d ${D}${datadir}/${BPN}/fusemaps
    for fusemap in ${S}/src/${GO_IMPORT}/fusemaps/*.yaml; do
        install -m 0644 ${fusemap} ${D}${datadir}/${BPN}/fusemaps
    done
}
