DESCRIPTION = "Boot script for launching OSTree based images with u-boot"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

INHIBIT_DEFAULT_DEPS = "1"

DEPENDS = "u-boot-mkimage-native"

SRC_URI = " \
    file://boot.cmd \
    file://uEnv.txt.in \
"

KERNEL_BOOTCMD ??= "bootz"
KERNEL_BOOTCMD_aarch64 ?= "booti"

S = "${WORKDIR}"
B = "${WORKDIR}/build"

# Allow transition to cover CVE-2021-27097 and CVE-2021-27138
FIT_NODE_SEPARATOR ?= "-"

inherit deploy

do_configure[noexec] = "1"

do_compile() {
    cp ${S}/boot.cmd ${B}/boot.cmd
    sed -e 's/@@KERNEL_BOOTCMD@@/${KERNEL_BOOTCMD}/' \
        -e 's/@@KERNEL_IMAGETYPE@@/${KERNEL_IMAGETYPE}/' \
        -e 's/@@FIT_NODE_SEPARATOR@@/${FIT_NODE_SEPARATOR}/g' \
        "${S}/uEnv.txt.in" > uEnv.txt
    mkimage -A arm -T script -C none -n "Ostree boot script" -d boot.cmd boot.scr
}

do_deploy() {
    install -d ${DEPLOYDIR}
    install -m 0644 boot.scr ${DEPLOYDIR}/boot.scr-${MACHINE}-${PV}-${PR}
    ln -sf boot.scr-${MACHINE}-${PV}-${PR} ${DEPLOYDIR}/boot.scr-${MACHINE}
    ln -sf boot.scr-${MACHINE}-${PV}-${PR} ${DEPLOYDIR}/boot.scr
    install -m 0644 uEnv.txt ${DEPLOYDIR}
}

addtask do_deploy after do_compile before do_build

PACKAGE_ARCH = "${MACHINE_ARCH}"

PROVIDES += "u-boot-default-script"
