SUMMARY = "OP-TEE Trusted OS"
DESCRIPTION = "Open Portable Trusted Execution Environment - Trusted side of the TEE"
HOMEPAGE = "https://www.op-tee.org/"

LICENSE = "BSD-2-Clause"
LIC_FILES_CHKSUM = "file://LICENSE;md5=c1f21c4f72f372ef38a5a4aee55ec173"

inherit deploy python3native
require optee.inc

CVE_PRODUCT = "linaro:op-tee op-tee:op-tee_os"

PROVIDES = "virtual/optee-os"

DEPENDS = "python3-pycryptodome-native python3-pycryptodomex-native python3-pyelftools-native"

DEPENDS_append_toolchain-clang = " compiler-rt"

SRCBRANCH ?= "master"
SRC_URI = "git://github.com/foundriesio/optee_os.git;protocol=https;branch=${SRCBRANCH}"

S = "${WORKDIR}/git"
B = "${WORKDIR}/build"

EXTRA_OEMAKE += " \
    PLATFORM=${OPTEEMACHINE} \
    CFG_${OPTEE_CORE}_core=y \
    CROSS_COMPILE_core=${HOST_PREFIX} \
    CROSS_COMPILE_ta_${OPTEE_ARCH}=${HOST_PREFIX} \
    CFG_WERROR=y DEBUG=0 \
    CFG_TEE_CORE_LOG_LEVEL=2 CFG_TEE_TA_LOG_LEVEL=2 \
    ta-targets=ta_${OPTEE_ARCH} \
    O=${B} \
"

CFLAGS[unexport] = "1"
LDFLAGS[unexport] = "1"
CPPFLAGS[unexport] = "1"
AS[unexport] = "1"
LD[unexport] = "1"

do_configure[noexec] = "1"

do_compile() {
    oe_runmake -C ${S} all
    readelf -h ${B}/core/tee.elf | grep Entry | awk '{print $4}' > ${B}/core/tee-init_load_addr.txt
}
do_compile[cleandirs] = "${B}"

do_install() {
    #install core in firmware
    install -d ${D}${nonarch_base_libdir}/firmware/
    install -m 644 ${B}/core/*.bin ${D}${nonarch_base_libdir}/firmware/

    #install TA devkit
    install -d ${D}${includedir}/optee/export-user_ta/
    for f in ${B}/export-ta_${OPTEE_ARCH}/* ; do
        cp -aR $f ${D}${includedir}/optee/export-user_ta/
    done

    # OP-TEE OS TAs
    install -d ${D}${nonarch_base_libdir}/optee_armtz
    install -m 0444 ${B}/ta/*/*.ta ${D}${nonarch_base_libdir}/optee_armtz
}

PACKAGE_ARCH = "${MACHINE_ARCH}"

do_deploy() {
    install -d ${DEPLOYDIR}/optee
    install -m 644 ${D}${nonarch_base_libdir}/firmware/* ${DEPLOYDIR}/optee/
    install -m 644 ${B}/core/tee-init_load_addr.txt ${DEPLOYDIR}/optee/

    # Link tee.bin so it can be consumed by recipes such as imx-boot
    ln -sf optee/tee-pager_v2.bin ${DEPLOYDIR}/tee.bin
}

addtask deploy before do_build after do_install

SYSROOT_DIRS += "${nonarch_base_libdir}/firmware"

PACKAGES += "${PN}-ta-pkcs11 ${PN}-ta"

FILES_${PN} = "${nonarch_base_libdir}/firmware/"
FILES_${PN}-ta = "${nonarch_base_libdir}/optee_armtz"
FILES_${PN}-ta-pkcs11 = "${nonarch_base_libdir}/optee_armtz/fd02c9da-306c-48c7-a49c-bbd827ae86ee.ta"
FILES_${PN}-dev = "${includedir}/optee/"

INSANE_SKIP_${PN}-dev = "staticdev"

INHIBIT_PACKAGE_STRIP = "1"
