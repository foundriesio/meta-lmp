SUMMARY = "OP-TEE Foundries.IO Verified Boot Client Application"
HOMEPAGE = "https://github.com/foundriesio/optee-fiovb"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=92d506fc36dda404ceb608cdc34b7a99"

DEPENDS = "optee-client"

require optee.inc

SRC_URI = "git://github.com/foundriesio/optee-fiovb.git"
SRCREV = "2fb0daf40597074dca13da664a8e2086751d80ac"

S = "${WORKDIR}/git"

do_compile() {
    oe_runmake -C ${S}/fiovb
}

do_install () {
    install -d ${D}${bindir}
    install -m 0755 ${S}/fiovb/host/fiovb ${D}${bindir}/fiovb
    ln -sf fiovb ${D}${bindir}/fiovb_printenv
    ln -sf fiovb ${D}${bindir}/fiovb_setenv
}
