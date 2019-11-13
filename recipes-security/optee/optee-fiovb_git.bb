SUMMARY = "OP-TEE Foundries.IO Verified Boot Client Application"
HOMEPAGE = "https://github.com/foundriesio/optee-fiovb"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=92d506fc36dda404ceb608cdc34b7a99"

DEPENDS = "optee-client virtual/optee-os python-pycrypto-native"

inherit pythonnative

SRC_URI = "git://github.com/foundriesio/optee-fiovb.git"

PV = "0.1"
SRCREV = "c7f80c69861628b1958ec35214afa2e0a0ae576d"

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
    install -m 0755 ${S}/out/ca/fiovb ${D}${bindir}
}
