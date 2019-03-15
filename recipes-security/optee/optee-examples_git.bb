SUMMARY = "OP-TEE examples"
HOMEPAGE = "https://github.com/linaro-swg/optee_examples"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=cd95ab417e23b94f381dafc453d70c30"

DEPENDS = "optee-client optee-os python-pycrypto-native"

inherit pythonnative

SRC_URI = "git://github.com/linaro-swg/optee_examples.git \
    file://fix-cross-build_secure_storage.patch \
    file://respect-ldflags-host-build.patch \
"

PV = "3.4.0+git${SRCPV}"
SRCREV = "9890a50d3c26b377dcb27f5db680018e15a5a3de"

S = "${WORKDIR}/git"

PACKAGE_ARCH = "${MACHINE_ARCH}"

OPTEE_CLIENT_EXPORT = "${STAGING_DIR_HOST}${prefix}"
TEEC_EXPORT         = "${STAGING_DIR_HOST}${prefix}"
TA_DEV_KIT_DIR      = "${STAGING_INCDIR}/optee/export-user_ta"

EXTRA_OEMAKE = "TA_DEV_KIT_DIR=${TA_DEV_KIT_DIR} \
                OPTEE_CLIENT_EXPORT=${OPTEE_CLIENT_EXPORT} \
                TEEC_EXPORT=${TEEC_EXPORT} \
                HOST_CROSS_COMPILE=${TARGET_PREFIX} \
                TA_CROSS_COMPILE=${TARGET_PREFIX} \
"

do_install () {
    install -d ${D}${bindir}
    install -d ${D}${nonarch_base_libdir}/optee_armtz
    install -m 0755 ${S}/out/ca/* ${D}${bindir}
    install -m 0444 ${S}/out/ta/* ${D}${nonarch_base_libdir}/optee_armtz
}

FILES_${PN} += "${nonarch_base_libdir}/optee_armtz/"
