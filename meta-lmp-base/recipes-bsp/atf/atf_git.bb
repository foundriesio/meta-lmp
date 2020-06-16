DESCRIPTION = "ARM Trusted Firmware"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://license.rst;md5=1dd070c98a281d18d9eefd938729b031"

TF-A_DEPENDS ?= ""

DEPENDS = "dtc-native coreutils-native openssl-native zip-native"
DEPENDS += " ${TF-A_DEPENDS}"
DEPENDS += " ${@bb.utils.contains("MACHINE_FEATURES", "optee", "virtual/optee-os", "", d)}"

SRC_URI = "git://github.com/ARM-software/arm-trusted-firmware.git"

PV = "2.2+git${SRCPV}"
SRCREV = "5d3ee0764b03567bf3501edf47d67d72daff0cb3"

S = "${WORKDIR}/git"
B = "${WORKDIR}/build"

inherit deploy

do_compile[depends] += " ${@bb.utils.contains("TF-A_DEPENDS", "u-boot", "u-boot:do_deploy", "", d)}"
do_compile[depends] += " ${@bb.utils.contains("MACHINE_FEATURES", "optee", "virtual/optee-os:do_deploy", "", d)}"

TF-A_PLATFORM ?= "${MACHINE}"
TF-A_DEBUG ?= "0"
TF-A_BL33 ?= ""

TF-A_TARGET_IMAGES ?= "all fip"
TF-A_EXTRA_OPTIONS ?= ""

CFLAGS[unexport] = "1"
LDFLAGS[unexport] = "1"
AS[unexport] = "1"
LD[unexport] = "1"

do_compile() {
    # These changes are needed to have the fiptool compiling and executing properly
    cd ${S}
    sed -i '/^LDLIBS/ s,$, \$\{BUILD_LDFLAGS},' ${S}/tools/fiptool/Makefile
    sed -i '/^INCLUDE_PATHS/ s,$, \$\{BUILD_CFLAGS},' ${S}/tools/fiptool/Makefile

    mkdir -p ${B}
    oe_runmake CROSS_COMPILE=${TARGET_PREFIX} BUILD_BASE=${B} \
        BUILD_PLAT=${B}/${TF-A_PLATFORM} PLAT=${TF-A_PLATFORM} \
        DEBUG=${TF-A_DEBUG} BL33=${TF-A_BL33} \
        ${@bb.utils.contains("MACHINE_FEATURES", "optee", "SPD=opteed", "", d)} \
        ${TF-A_EXTRA_OPTIONS} ${TF-A_TARGET_IMAGES}
}

do_install() {
    install -d ${D}${libdir}/atf
    for f in bl1.bin bl1.elf bl2.bin bl31.bin fip.bin; do
        if [ -f "${B}/${TF-A_PLATFORM}/${f}" ]; then
            install -p -m 644 ${B}/${TF-A_PLATFORM}/${f} ${D}${libdir}/atf
        fi
    done
}

do_deploy() {
    install -d ${DEPLOYDIR}/atf
    cp -a ${D}${libdir}/atf/* ${DEPLOYDIR}/atf
}

addtask deploy after do_install

FILES_${PN} += "${libdir}/atf"
INSANE_SKIP_${PN} += "installed-vs-shipped"
