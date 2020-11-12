SUMMARY = "OP-TEE sanity testsuite"
HOMEPAGE = "https://github.com/OP-TEE/optee_test"
LICENSE = "BSD & GPLv2"
LIC_FILES_CHKSUM = "file://${S}/LICENSE.md;md5=daa2bcccc666345ab8940aab1315a4fa"

DEPENDS = "optee-client virtual/optee-os python3-pycryptodomex-native python3-pycrypto-native openssl"

inherit python3native

SRC_URI = "git://github.com/OP-TEE/optee_test.git \
    file://allow-custom-bin-lib-dir-3.9.0.patch \
    file://0001-os_test-disable-c-tests.patch \
"

PV = "3.10.0"
SRCREV = "30efcbeaf8864d0f2a5c4be593a5411001fab31b"

S = "${WORKDIR}/git"

PACKAGE_ARCH = "${MACHINE_ARCH}"
OPTEE_ARCH_armv7a = "arm"
OPTEE_ARCH_armv7ve = "arm"
OPTEE_ARCH_aarch64 = "arm64"

OPTEE_CLIENT_EXPORT = "${STAGING_DIR_HOST}${prefix}"
TEEC_EXPORT         = "${STAGING_DIR_HOST}${prefix}"
TA_DEV_KIT_DIR      = "${STAGING_INCDIR}/optee/export-user_ta"

# TA Signing Key, can be set to replace the default RSA 2048 key (default_key.pem)
OPTEE_TA_SIGN_KEY ?= ""

EXTRA_OEMAKE = "ARCH=${OPTEE_ARCH} TA_DEV_KIT_DIR=${TA_DEV_KIT_DIR} \
                OPTEE_CLIENT_EXPORT=${OPTEE_CLIENT_EXPORT} \
                TEEC_EXPORT=${TEEC_EXPORT} \
                LIBGCC_LOCATE_CFLAGS=--sysroot=${STAGING_DIR_HOST} \
                OPTEE_OPENSSL_EXPORT=${STAGING_INCDIR} \
                CROSS_COMPILE_HOST=${TARGET_PREFIX} \
                CROSS_COMPILE_TA=${TARGET_PREFIX} \
                BINDIR=${base_bindir} LIBDIR=${nonarch_base_libdir} \
                DESTDIR=${D} \
"
EXTRA_OEMAKE += "${@oe.utils.ifelse('${OPTEE_TA_SIGN_KEY}' != '', 'TA_SIGN_KEY=${OPTEE_TA_SIGN_KEY}', '')}"

do_install () {
    oe_runmake install

    chown -R root:root ${D}
}

FILES_${PN} += "${nonarch_base_libdir}/optee_armtz/"
