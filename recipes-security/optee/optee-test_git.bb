SUMMARY = "OP-TEE sanity testsuite"
HOMEPAGE = "https://github.com/OP-TEE/optee_test"
LICENSE = "BSD & GPLv2"
LIC_FILES_CHKSUM = "file://${S}/LICENSE.md;md5=daa2bcccc666345ab8940aab1315a4fa"

DEPENDS = "optee-client optee-os python-pycrypto-native"

inherit pythonnative

SRC_URI = "git://github.com/OP-TEE/optee_test.git \
    file://allow-custom-bin-lib-dir.patch \
"

PV = "3.5.0+git${SRCPV}"
SRCREV = "40aacb6dc33bbf6ee329f40274bfe7bb438bbf53"

S = "${WORKDIR}/git"

PACKAGE_ARCH = "${MACHINE_ARCH}"

OPTEE_CLIENT_EXPORT = "${STAGING_DIR_HOST}${prefix}"
TEEC_EXPORT         = "${STAGING_DIR_HOST}${prefix}"
TA_DEV_KIT_DIR      = "${STAGING_INCDIR}/optee/export-user_ta"

EXTRA_OEMAKE = "TA_DEV_KIT_DIR=${TA_DEV_KIT_DIR} \
                OPTEE_CLIENT_EXPORT=${OPTEE_CLIENT_EXPORT} \
                TEEC_EXPORT=${TEEC_EXPORT} \
                CROSS_COMPILE_HOST=${TARGET_PREFIX} \
                CROSS_COMPILE_TA=${TARGET_PREFIX} \
                BINDIR=${base_bindir} LIBDIR=${nonarch_base_libdir} \
                DESTDIR=${D} \
"

do_install () {
    oe_runmake install

    chown -R root:root ${D}
}

FILES_${PN} += "${nonarch_base_libdir}/optee_armtz/"
