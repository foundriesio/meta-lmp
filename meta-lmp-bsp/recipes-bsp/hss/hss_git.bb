SUMMARY = "Microchip Polarfire SoC Hart Software Services (HSS) Payload Generator"
DESCRIPTION = "HSS requires U-Boot to be packaged with header details applied with hss payload generator"

LICENSE = "MIT & BSD-2-Clause"
LIC_FILES_CHKSUM = "file://LICENSE.md;md5=2dc9e752dd76827e3a4eebfd5b3c6226"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

inherit deploy

# strict dependency
do_configure[depends] += "u-boot:do_deploy"

DEPENDS += " \
    libyaml-native \
    elfutils-native \
"

PV = "1.0+git${SRCPV}"
BRANCH = "master"
SRCREV = "76b34dd0212425f9848eed41575db22cd829cecb"

SRC_URI = " \
    git://github.com/polarfire-soc/hart-software-services.git;branch=${BRANCH} \
    file://uboot.yaml \
    file://0001-OE-Fixup-Makefile.patch \
"

S = "${WORKDIR}/git"

EXTRA_OEMAKE += 'HOSTCC="${BUILD_CC} ${BUILD_CFLAGS} ${BUILD_LDFLAGS}"'

# NOTE: Only using the Payload generator from the HSS

do_configure() {
    ## taking U-Boot binary and package for HSS
    cp -f ${DEPLOY_DIR_IMAGE}/u-boot.bin ${S}/
    cp -f ${WORKDIR}/uboot.yaml ${S}/tools/hss-payload-generator/
}

do_compile() {
    ## Adding u-boot as a payload
    ## Using hss-payload-generator application
    oe_runmake -C ${S}/tools/hss-payload-generator
    ${S}/tools/hss-payload-generator/hss-payload-generator -c ${S}/tools/hss-payload-generator/uboot.yaml -v payload.bin
}

do_deploy() {
    install -d ${DEPLOYDIR}
    install -m 755 ${WORKDIR}/git/payload.bin ${DEPLOYDIR}/
}

addtask deploy after do_compile before do_build
