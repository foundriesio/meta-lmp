DESCRIPTION = "NXP Plug and Trust Middleware Demos with SETEEC support"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

SRC_URI = "git://github.com/foundriesio/plug-and-trust-demos;branch=v04.02.00;protocol=https"
SRCREV = "20ddccee11ffa915713b47b50efa89856b0a890c"

DEPENDS = "plug-and-trust-seteec"

inherit cmake dos2unix

S = "${WORKDIR}/git"

EXTRA_OECMAKE += "\
    -DSIMW_TOP_DIR=${WORKDIR}/recipe-sysroot/usr/include/se05x \
"
