SUMMARY = "OP-TEE examples"
HOMEPAGE = "https://github.com/linaro-swg/optee_examples"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=cd95ab417e23b94f381dafc453d70c30"

inherit python3native

DEPENDS = "optee-client virtual/optee-os python3-pycrypto-native"

SRC_URI = "git://github.com/linaro-swg/optee_examples.git \
    file://respect-ldflags-host-build.patch \
"

PV = "3.6.0"
SRCREV = "292da2fd8db0176e0e96989268c63ef9ab910a6c"

S = "${WORKDIR}/git"

PACKAGE_ARCH = "${MACHINE_ARCH}"

OPTEE_CLIENT_EXPORT = "${STAGING_DIR_HOST}${prefix}"
TEEC_EXPORT         = "${STAGING_DIR_HOST}${prefix}"
TA_DEV_KIT_DIR      = "${STAGING_INCDIR}/optee/export-user_ta"

# TA Signing Key, can be set to replace the default RSA 2048 key (default_key.pem)
OPTEE_TA_SIGN_KEY ?= ""

EXTRA_OEMAKE = "TA_DEV_KIT_DIR=${TA_DEV_KIT_DIR} \
                OPTEE_CLIENT_EXPORT=${OPTEE_CLIENT_EXPORT} \
                TEEC_EXPORT=${TEEC_EXPORT} \
                HOST_CROSS_COMPILE=${TARGET_PREFIX} \
                TA_CROSS_COMPILE=${TARGET_PREFIX} \
"
EXTRA_OEMAKE += "${@oe.utils.ifelse('${OPTEE_TA_SIGN_KEY}' != '', 'TA_SIGN_KEY=${OPTEE_TA_SIGN_KEY}', '')}"

do_install () {
    install -d ${D}${bindir}
    install -d ${D}${nonarch_base_libdir}/optee_armtz
    install -m 0755 ${S}/out/ca/* ${D}${bindir}
    install -m 0444 ${S}/out/ta/* ${D}${nonarch_base_libdir}/optee_armtz
}

FILES_${PN} += "${nonarch_base_libdir}/optee_armtz/"
