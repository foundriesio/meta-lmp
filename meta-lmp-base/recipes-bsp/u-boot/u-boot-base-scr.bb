DESCRIPTION = "Boot script for launching lmp base images with u-boot (no ostree)"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

DEPENDS = "u-boot-mkimage-native"

SRC_URI = " \
    file://boot.cmd \
    file://uEnv.txt.in \
"

KERNEL_BOOTCMD ??= "bootz"
KERNEL_BOOTCMD:aarch64 ?= "booti"

S = "${WORKDIR}"

inherit deploy

do_compile() {
    sed -e 's/@@KERNEL_BOOTCMD@@/${KERNEL_BOOTCMD}/' \
        "${WORKDIR}/uEnv.txt.in" > uEnv.txt
    mkimage -A arm -T script -C none -n "LMP base boot script" -d "${WORKDIR}/boot.cmd" boot.scr
}

do_deploy() {
    install -d ${DEPLOYDIR}
    install -m 0644 boot.scr ${DEPLOYDIR}/boot.scr-${MACHINE}-${PV}
    ln -sf boot.scr-${MACHINE}-${PV} ${DEPLOYDIR}/boot.scr-${MACHINE}
    ln -sf boot.scr-${MACHINE}-${PV} ${DEPLOYDIR}/boot.scr
    install -m 0644 uEnv.txt ${DEPLOYDIR}
}

do_install() {
    mkdir -p ${D}/boot
    install -m 0644 boot.scr ${D}/boot.scr
    install -m 0644 uEnv.txt ${D}/boot/uEnv.txt
}

FILES:${PN} += " \
    boot.scr \
    boot/uEnv.txt \
"
addtask do_deploy after do_compile before do_build

PROVIDES += "u-boot-default-script"
RPROVIDES:${PN} += "u-boot-default-script"
