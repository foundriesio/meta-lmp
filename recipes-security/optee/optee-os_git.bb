SUMMARY = "OP-TEE Trusted OS"
DESCRIPTION = "OPTEE OS"
LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=c1f21c4f72f372ef38a5a4aee55ec173"

DEPENDS = "python-pycrypto-native"

SRC_URI = "git://github.com/OP-TEE/optee_os.git \
    file://0001-allow-setting-sysroot-for-libgcc-lookup.patch \
"

PV = "3.4.0+git${SRCPV}"
SRCREV = "f831c1621ed4578733ff9b4319ba719600c0dfff"

S = "${WORKDIR}/git"

inherit deploy pythonnative

OPTEEMACHINE ?= "${MACHINE}"
OPTEEMACHINE_qemuarm64 = "vexpress-qemu_armv8a"

PACKAGE_ARCH = "${MACHINE_ARCH}"
OPTEE_ARCH_armv7a = "arm32"
OPTEE_ARCH_aarch64 = "arm64"

EXTRA_OEMAKE = "PLATFORM=${OPTEEMACHINE} O=out/arm \
                CROSS_COMPILE_core=${HOST_PREFIX} \
                DEBUG=0 CFG_PM_DEBUG=0 LDFLAGS= \
                LIBGCC_LOCATE_CFLAGS=--sysroot=${STAGING_DIR_HOST} \
"
EXTRA_OEMAKE_append_aarch64 = " \
                CFG_ARM64_core=y \
                CROSS_COMPILE_ta_arm64=${HOST_PREFIX} \
                ta-targets=ta_arm64 \
"
EXTRA_OEMAKE_append_armv7a = " \
                CROSS_COMPILE_ta_arm32=${HOST_PREFIX} \
"

do_install() {
    # TA devkit
    install -d ${D}/usr/include/optee/export-user_ta/
    for f in ${B}/out/arm/export-ta_${OPTEE_ARCH}/* ; do
        cp -aR $f ${D}/usr/include/optee/export-user_ta/
    done
}

do_deploy() {
    install -d ${DEPLOYDIR}/optee
    for f in ${B}/out/arm/core/*.bin; do
        install -m 644 $f ${DEPLOYDIR}/optee/
    done
}

addtask deploy before do_build after do_install

FILES_${PN}-dev = "/usr/include/optee"
INSANE_SKIP_${PN}-dev = "staticdev"
INHIBIT_PACKAGE_STRIP = "1"
