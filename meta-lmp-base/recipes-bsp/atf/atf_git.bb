DESCRIPTION = "ARM Trusted Firmware"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://license.rst;md5=90153916317c204fade8b8df15739cde"

DEPENDS = "u-boot openssl-native zip-native"
DEPENDS += " ${@bb.utils.contains("MACHINE_FEATURES", "optee", "virtual/optee-os", "", d)}"

SRC_URI = "git://github.com/ARM-software/arm-trusted-firmware.git"

PV = "2.1+git${SRCPV}"
SRCREV = "ed01e0c407a1794faf8ff8173183a50419bbd2ae"

S = "${WORKDIR}/git"

inherit deploy

do_compile[depends] += "u-boot:do_deploy virtual/optee-os:do_deploy"

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

addtask deploy after do_install

FILES_${PN} += "${libdir}/atf/*.bin"
INSANE_SKIP_${PN} += "installed-vs-shipped"
