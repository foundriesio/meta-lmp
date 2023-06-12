SUMMARY = "OP-TEE Trusted OS"
DESCRIPTION = "Open Portable Trusted Execution Environment - Trusted side of the TEE"
HOMEPAGE = "https://www.op-tee.org/"

LICENSE = "BSD-2-Clause"
LIC_FILES_CHKSUM = "file://LICENSE;md5=c1f21c4f72f372ef38a5a4aee55ec173"

inherit deploy

DEPENDS = "python3-pyelftools-native dtc-native"

DEPENDS:append:toolchain-clang = " compiler-rt"

require optee-fio.inc

# SE05X support
require ${@bb.utils.contains('MACHINE_FEATURES', 'se05x', 'optee-os-fio-se05x.inc', '', d)}

CVE_PRODUCT = "linaro:op-tee op-tee:op-tee_os"

PROVIDES = "virtual/optee-os"

SRCBRANCH ?= "master"
OPTEE_OS_REPO ?= "git://github.com/foundriesio/optee_os.git"
SRC_URI = "${OPTEE_OS_REPO};protocol=https;branch=${SRCBRANCH}"

FILESEXTRAPATHS:prepend := "${THISDIR}/files:"
SRC_URI:append:mx8ulp-nxp-bsp = " \
	file://0001-FIO-fromtree-core-mm-Fix-conflicting-types-due-to-en.patch \
	file://0002-FIO-fromtree-ta-pkcs11-Fix-conflicting-types-due-to-.patch \
	"
SRC_URI:append:mx93-nxp-bsp = " \
	file://0001-FIO-fromtree-core-mm-Fix-conflicting-types-due-to-en.patch \
	file://0002-FIO-fromtree-ta-pkcs11-Fix-conflicting-types-due-to-.patch \
	"

S = "${WORKDIR}/git"
B = "${WORKDIR}/build"

PKCS11_TA_HEAP_SIZE ??= "65536"

EXTRA_OEMAKE += " \
    PLATFORM=${OPTEEMACHINE} \
    CFG_${OPTEE_CORE}_core=y \
    CROSS_COMPILE_core=${HOST_PREFIX} \
    CROSS_COMPILE_ta_${OPTEE_ARCH}=${HOST_PREFIX} \
    CFG_WERROR=y DEBUG=0 CFG_OPTEE_REVISION_EXTRA=+fio \
    CFG_TEE_CORE_LOG_LEVEL=2 CFG_TEE_TA_LOG_LEVEL=2 \
    CFG_PKCS11_TA_HEAP_SIZE=${PKCS11_TA_HEAP_SIZE} \
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
    install -m 644 ${B}/core/*.bin ${B}/core/tee.elf ${D}${nonarch_base_libdir}/firmware/

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

    # Deploy optee_os config used during build
    install -D -m 644 ${B}/conf.mk ${DEPLOYDIR}/${PN}-config-${MACHINE}-${PV}-${PR}
    ln -sf ${PN}-config-${MACHINE}-${PV}-${PR} ${DEPLOYDIR}/${PN}-config-${MACHINE}
    ln -sf ${PN}-config-${MACHINE}-${PV}-${PR} ${DEPLOYDIR}/${PN}-config
}

addtask deploy before do_build after do_install

SYSROOT_DIRS += "${nonarch_base_libdir}/firmware"

PACKAGES += "${PN}-ta"
RPROVIDES:${PN}-ta = "virtual-optee-os-ta"

FILES:${PN} = "${nonarch_base_libdir}/firmware/"
FILES:${PN}-ta = "${nonarch_base_libdir}/optee_armtz"

# note: "textrel" is not triggered on all archs
INSANE_SKIP:${PN} = "textrel"
INSANE_SKIP:${PN}-dev = "staticdev"

INHIBIT_PACKAGE_STRIP = "1"
