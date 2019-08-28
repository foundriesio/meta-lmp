SUMMARY = "OP-TEE TA/Library for Secure Key Services (PKCS#11)"
HOMEPAGE = "https://github.com/foundriesio/optee-sks"
LICENSE = "BSD-2-Clause"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/BSD-2-Clause;md5=8bef8e6712b1be5aa76af1ebde9d6378"

inherit pythonnative

DEPENDS = "python-pycrypto-native optee-os optee-client"

SRC_URI = "git://github.com/foundriesio/optee-sks.git"
SRCREV = "${AUTOREV}"

S = "${WORKDIR}/git"

PACKAGE_ARCH = "${MACHINE_ARCH}"

# Other security flags already maintained via flags.mk
SECURITY_CFLAGS = "${SECURITY_STACK_PROTECTOR}"

OPTEE_CLIENT_EXPORT = "${STAGING_DIR_HOST}${prefix}"
TEEC_EXPORT         = "${STAGING_DIR_HOST}${prefix}"
TA_DEV_KIT_DIR      = "${STAGING_INCDIR}/optee/export-user_ta"

EXTRA_OEMAKE = "TA_DEV_KIT_DIR=${TA_DEV_KIT_DIR} \
                OPTEE_CLIENT_EXPORT=${OPTEE_CLIENT_EXPORT} \
                TEEC_EXPORT=${TEEC_EXPORT} \
                HOST_CROSS_COMPILE=${TARGET_PREFIX} \
                TA_CROSS_COMPILE=${TARGET_PREFIX} \
"
EXTRA_OEMAKE += "${@oe.utils.ifelse('${OPTEE_TA_SIGN_KEY}' != '', 'TA_SIGN_KEY=${OPTEE_TA_SIGN_KEY}', '')}"

do_compile() {
    # TA SKS
    oe_runmake -C ${S}/ta/secure_key_services O=${S}/out/ta

    # SKS client library
    oe_runmake -C ${S}/libsks O=${S}/out
}

do_install () {
    # TA SKS
    install -d ${D}${nonarch_base_libdir}/optee_armtz
    install -m 0444 out/ta/*.ta ${D}${nonarch_base_libdir}/optee_armtz

    # SKS client library
    install -d ${D}${libdir}
    install -m 0644 out/libsks/libsks.a ${D}${libdir}
    install -m 0755 out/libsks/libsks.so.* ${D}${libdir}
    cp -R --no-dereference --preserve=mode,links -v out/libsks/libsks.so ${D}${libdir}
}

FILES_${PN} += "${nonarch_base_libdir}/optee_armtz/"
