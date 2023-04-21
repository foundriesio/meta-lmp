SUMMARY = "MFGTOOL Support Files and Binaries"
LICENSE = "BSD-3-Clause & LGPLv2.1+"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/BSD-3-Clause;md5=550794465ba0ec5312d6919e203a55f9 \
                    file://${COMMON_LICENSE_DIR}/LGPL-2.1-or-later;md5=2a4f4fd2128ea2f65047ee63fbca9f68"

inherit deploy nopackages

# Use installer initramfs
INITRAMFS_IMAGE ?= "initramfs-ostree-lmp-recovery"
DEPENDS = "${INITRAMFS_IMAGE}"

S = "${WORKDIR}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

LMP_FLASHLAYOUT_TEMPLATE ?= "FlashLayout_stm32mp1-usb.tsv.in"
SRC_URI = " \
    file://${LMP_FLASHLAYOUT_TEMPLATE} \
    file://provision.sh.in \
"

do_compile() {
    sed -e 's/@@IMAGE@@/${MFGTOOL_FLASH_IMAGE}/' \
        -e 's/@@MACHINE@@/${MACHINE}/' \
        -e 's/@@BOARD_NAME@@/${LMP_FLASHLAYOUT_BOARD_NAME}/' \
        -e 's/@@BOARD_DISK@@/${LMP_FLASHLAYOUT_BOARD_DISK}/' \
        -e 's/@@BOARD_OFFSET_FSBL1@@/${LMP_FLASHLAYOUT_BOARD_OFFSET_FSBL1}/' \
        -e 's/@@BOARD_OFFSET_FSBL2@@/${LMP_FLASHLAYOUT_BOARD_OFFSET_FSBL2}/' \
        -e 's/@@BOARD_OFFSET_FIP@@/${LMP_FLASHLAYOUT_BOARD_OFFSET_FIP}/' \
        -e 's/@@BOARD_OFFSET_ROOT@@/${LMP_FLASHLAYOUT_BOARD_OFFSET_ROOT}/' \
        ${WORKDIR}/${LMP_FLASHLAYOUT_TEMPLATE} > ${WORKDIR}/${LMP_FLASHLAYOUT}
    sed -e 's/@@MACHINE@@/${MACHINE}/' \
        -e 's/@@BOARD_NAME@@/${LMP_FLASHLAYOUT_BOARD_NAME}/' \
        ${WORKDIR}/provision.sh.in > ${WORKDIR}/provision.sh
}

do_deploy() {
    install -d ${DEPLOYDIR}/${PN}
    install -m 0755 ${WORKDIR}/*.tsv ${DEPLOYDIR}/${PN}
    install -m 0755 ${WORKDIR}/provision.sh ${DEPLOYDIR}/${PN}
    install -m 0644 ${DEPLOY_DIR_IMAGE}/arm-trusted-firmware/tf-a-${LMP_FLASHLAYOUT_BOARD_NAME}-usb.stm32 ${DEPLOYDIR}/${PN}/
    install -m 0644 ${DEPLOY_DIR_IMAGE}/fip/fip-${LMP_FLASHLAYOUT_BOARD_NAME}-optee.bin ${DEPLOYDIR}/${PN}/
    install -m 0644 ${DEPLOY_DIR_IMAGE}/fitImage-${INITRAMFS_IMAGE}-${MACHINE}-${MACHINE} ${DEPLOYDIR}/${PN}/fitImage-mfgtool

    tar -czf ${DEPLOYDIR}/${PN}-${MACHINE}.tar.gz \
            --transform "s,^mfgtool-files,mfgtool-files-${MACHINE}," \
            -C ${DEPLOYDIR} ${PN}

    ln -s ${PN}-${MACHINE}.tar.gz ${DEPLOYDIR}/${PN}.tar.gz
}

# Make sure the signed fitImage and u-boot are deployed
do_deploy[depends] += "virtual/trusted-firmware-a:do_deploy"
do_deploy[depends] += "virtual/bootloader:do_deploy"
do_deploy[depends] += "virtual/kernel:do_deploy"

addtask deploy after do_compile before do_build

python() {
    # we need to set the DEPENDS as well to produce valid SPDX documents
    fix_deployed_depends('do_deploy', d)
}
