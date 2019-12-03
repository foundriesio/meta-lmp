SUMMARY = "OP-TEE Foundries.IO Verified Boot Client Application"
HOMEPAGE = "https://github.com/foundriesio/optee-fiovb"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=92d506fc36dda404ceb608cdc34b7a99"

DEPENDS = "optee-client virtual/optee-os python-pycrypto-native"

inherit pythonnative

SRC_URI = "git://github.com/foundriesio/optee-fiovb.git"

PV = "0.1"
SRCREV = "829d30d98be554ffad943f44ecf197224abc9ec2"

S = "${WORKDIR}/git"

PACKAGE_ARCH = "${MACHINE_ARCH}"

OPTEE_CLIENT_EXPORT = "${STAGING_DIR_HOST}${prefix}"
TEEC_EXPORT         = "${STAGING_DIR_HOST}${prefix}"

EXTRA_OEMAKE = "OPTEE_CLIENT_EXPORT=${OPTEE_CLIENT_EXPORT} \
                TEEC_EXPORT=${TEEC_EXPORT} \
                HOST_CROSS_COMPILE=${TARGET_PREFIX} \
"

do_install () {
    install -d ${D}${bindir}
    install -m 0755 ${S}/out/ca/fiovb ${D}${bindir}/fiovb
    ln -sf fiovb ${D}${bindir}/fiovb_printenv
    ln -sf fiovb ${D}${bindir}/fiovb_setenv
}
