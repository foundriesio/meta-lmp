SUMMARY = "OP-TEE Foundries.IO Verified Boot Client Application"
HOMEPAGE = "https://github.com/foundriesio/optee-fiovb"
LICENSE = "BSD-2-Clause"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=92d506fc36dda404ceb608cdc34b7a99"

DEPENDS = "optee-client optee-os-tadevkit"

require optee-fio.inc

SRC_URI = "git://github.com/foundriesio/optee-fiovb.git;protocol=https;branch=master"
SRCREV = "e23cc95bb6869571862327d799f0dac3ecba4f81"

PACKAGE_ARCH = "${MACHINE_ARCH}"

S = "${WORKDIR}/git"

EXTRA_OEMAKE += "TA_DEV_KIT_DIR=${TA_DEV_KIT_DIR} \
                 HOST_CROSS_COMPILE=${HOST_PREFIX} \
                 TA_CROSS_COMPILE=${HOST_PREFIX} \
"

do_compile() {
    oe_runmake -C ${S}/fiovb
}

do_install () {
    # TA
    install -d ${D}${nonarch_base_libdir}/optee_armtz
    install -m 0444 ${S}/fiovb/ta/*.ta ${D}${nonarch_base_libdir}/optee_armtz
    install -m 0444 ${S}/fiovb/ta/*.stripped.elf ${D}${nonarch_base_libdir}/optee_armtz

    # Host tools
    install -d ${D}${bindir}
    install -m 0755 ${S}/fiovb/host/fiovb ${D}${bindir}/fiovb
    ln -sf fiovb ${D}${bindir}/fiovb_printenv
    ln -sf fiovb ${D}${bindir}/fiovb_setenv
    ln -sf fiovb ${D}${bindir}/fiovb_delenv
}

FILES:${PN} += "${nonarch_base_libdir}/optee_armtz/"
