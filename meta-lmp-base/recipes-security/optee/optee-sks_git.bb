SUMMARY = "OP-TEE TA/Library for Secure Key Services (PKCS#11)"
HOMEPAGE = "https://github.com/foundriesio/optee-sks"
LICENSE = "BSD-2-Clause"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/BSD-2-Clause;md5=cb641bc04cda31daea161b1bc15da69f"

inherit python3native

require optee.inc

DEPENDS = "python3-pycryptodomex-native python3-pycrypto-native virtual/optee-os optee-client"

SRC_URI = "git://github.com/foundriesio/optee-sks.git"
SRCREV = "c5e0ae747c84b496585c4de7e4bded025e24959b"

S = "${WORKDIR}/git"
B = "${WORKDIR}/build"

PACKAGE_ARCH = "${MACHINE_ARCH}"

# Other security flags already maintained via flags.mk
SECURITY_CFLAGS = "${SECURITY_STACK_PROTECTOR}"

EXTRA_OEMAKE += "TA_DEV_KIT_DIR=${TA_DEV_KIT_DIR} \
                 HOST_CROSS_COMPILE=${HOST_PREFIX} \
                 TA_CROSS_COMPILE=${HOST_PREFIX} \
               "

do_compile() {
    # TA SKS
    oe_runmake -C ${S}/ta/secure_key_services O=${B}/ta

    # SKS client library
    oe_runmake -C ${S}/libsks O=${B}
}
do_compile[cleandirs] = "${B}"

do_install () {
    # TA SKS
    install -d ${D}${nonarch_base_libdir}/optee_armtz
    install -m 0444 ${B}/ta/*.ta ${D}${nonarch_base_libdir}/optee_armtz

    # SKS client library
    install -d ${D}${libdir}
    install -m 0644 ${B}/libsks/libsks.a ${D}${libdir}
    install -m 0755 ${B}/libsks/libsks.so.* ${D}${libdir}
    cp -R --no-dereference --preserve=mode,links -v ${B}/libsks/libsks.so ${D}${libdir}
}

FILES_${PN} += "${nonarch_base_libdir}/optee_armtz/"
