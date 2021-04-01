DESCRIPTION = "One-Time-Programmable (OTP) fusing tool"
HOMEPAGE = "https://github.com/inversepath/crucible"
SECTION = "devel"
LICENSE = "GPLv3"
LIC_FILES_CHKSUM = "file://src/${GO_IMPORT}/LICENSE;md5=d1e4913d52e4dda553dcd90e8cd279c4"

SRC_URI = "git://${GO_IMPORT} \
    file://set-default-fusemaps-dir.patch \
"
SRCREV = "5713dd693f8ceecd175d4e7b9029a2c02c2c89ea"
UPSTREAM_CHECK_COMMITS = "1"
PV = "0.1+git${SRCPV}"

GO_IMPORT = "github.com/inversepath/crucible"

inherit go dos2unix

do_install_append() {
    install -d ${D}${datadir}/${BPN}/fusemaps
    for fusemap in ${S}/src/${GO_IMPORT}/fusemaps/*.yaml; do
        install -m 0644 ${fusemap} ${D}${datadir}/${BPN}/fusemaps
    done
}
