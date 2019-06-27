DESCRIPTION = "ARM Trusted Firmware"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://license.rst;md5=90153916317c204fade8b8df15739cde"

DEPENDS = "u-boot openssl-native zip-native"
DEPENDS += " ${@bb.utils.contains("MACHINE_FEATURES", "optee", "optee-os", "", d)}"

SRC_URI = "git://github.com/ARM-software/arm-trusted-firmware.git"

PV = "2.1+git${SRCPV}"
SRCREV = "e9e74aa4c8b06d40c7fd300d9dd0e668f25f2b6e"

S = "${WORKDIR}/git"

inherit deploy

do_compile[depends] += "u-boot:do_deploy optee-os:do_deploy"

COMPATIBLE_MACHINE = "(qemuarm64)"

PLATFORM = "${MACHINE}"
PLATFORM_qemuarm64 = "qemu"

EXTRA_OEMAKE = "CROSS_COMPILE=${TARGET_PREFIX} \
    DEBUG=0 \
    LOG_LEVEL=30 \
"
EXTRA_OEMAKE_append_qemuarm64 = " \
    BL32=${DEPLOY_DIR_IMAGE}/optee/tee-header_v2.bin \
    BL32_EXTRA1=${DEPLOY_DIR_IMAGE}/optee/tee-pager_v2.bin \
    BL32_EXTRA2=${DEPLOY_DIR_IMAGE}/optee/tee-pageable_v2.bin \
    BL33=${DEPLOY_DIR_IMAGE}/u-boot.bin \
    ARM_TSP_RAM_LOCATION=tdram \
    BL32_RAM_LOCATION=tdram \
    SPD=opteed \
"

CFLAGS[unexport] = "1"
LDFLAGS[unexport] = "1"
AS[unexport] = "1"
LD[unexport] = "1"

do_compile() {
    oe_runmake PLAT=${PLATFORM} all fip
}

do_install() {
    install -d ${D}${libdir}/atf
    for f in bl1.bin bl2.bin bl31.bin fip.bin; do
        install -p -m 644 ${S}/build/${PLATFORM}/release/${f} ${D}${libdir}/atf
    done
}

do_deploy() {
    install -d ${DEPLOYDIR}/atf
    cp -a ${D}${libdir}/atf/*.bin ${DEPLOYDIR}/atf
}

do_deploy_append_qemuarm64() {
    ln -sf ../optee/tee-header_v2.bin ${DEPLOYDIR}/atf/bl32.bin
    ln -sf ../optee/tee-pager_v2.bin ${DEPLOYDIR}/atf/bl32_extra1.bin
    ln -sf ../optee/tee-pageable_v2.bin ${DEPLOYDIR}/atf/bl32_extra2.bin
    ln -sf ../u-boot.bin ${DEPLOYDIR}/atf/bl33.bin
}

addtask deploy after do_install

FILES_${PN} += "${libdir}/atf/*.bin"
INSANE_SKIP_${PN} += "installed-vs-shipped"
