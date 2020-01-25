SUMMARY = "OP-TEE sanity testsuite"
HOMEPAGE = "https://github.com/OP-TEE/optee_test"
LICENSE = "BSD & GPLv2"
LIC_FILES_CHKSUM = "file://${S}/LICENSE.md;md5=daa2bcccc666345ab8940aab1315a4fa"

DEPENDS = "optee-client virtual/optee-os python3-pycrypto-native openssl"

inherit python3native

SRC_URI = "git://github.com/OP-TEE/optee_test.git \
    file://allow-custom-bin-lib-dir.patch \
    file://use-python3-instead-of-python.patch \
"

PV = "3.6.0"
SRCREV = "40aacb6dc33bbf6ee329f40274bfe7bb438bbf53"

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
