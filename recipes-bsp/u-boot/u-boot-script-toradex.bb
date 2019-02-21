# Based on u-boot-script-toradex from meta-boot2qt
#
# Copyright (C) 2017 The Qt Company Ltd.
# Copyright (C) 2018 Open Source Foundries Ltd.

LICENSE = "GPLv3+"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/GPL-3.0;md5=c79ff39f19dfec6d293b95dea7b07891"
DEPENDS = "u-boot-mkimage-native"

COMPATIBLE_MACHINE = "(apalis-imx6|colibri-imx7)"

SRC_URI = " \
    file://flash_blk.scr \
    file://flash_eth.scr \
"

S = "${WORKDIR}"

inherit deploy

do_mkimage () {
    for scr in ${WORKDIR}/*.scr; do
        uboot-mkimage -A arm -O linux -T script -C none -a 0 -e 0 \
                  -n "update script" -d ${scr} \
                  ${S}/$(basename ${scr} .scr).img
    done
}

addtask mkimage after do_compile before do_install

do_deploy () {
    install -d ${DEPLOYDIR}/${MACHINE_ARCH}
    install -m 0644 -t ${DEPLOYDIR}/${MACHINE_ARCH} ${S}/*.img
}

addtask deploy after do_install before do_build
