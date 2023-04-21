DESCRIPTION = "A simple recipe to deliver flashlayout files for STM32MP1 platforms"
HOMEPAGE = "https://st.com"
SECTION = "base"
LICENSE = "MPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MPL-2.0;md5=815ca599c9df247a0c7f619bab123dad"

inherit deploy

DEPENDS = "sdcard-raw-tools-native"

MFGTOOL_FLASH_IMAGE ?= "lmp-base-console-image"

LMP_FLASHLAYOUT_TEMPLATE ?= "FlashLayout_stm32mp1-optee.tsv.in"
LMP_FLASHLAYOUT_IMAGE = "${MFGTOOL_FLASH_IMAGE}-${MACHINE}.${@bb.utils.contains('DISTRO_FEATURES', 'sota', 'ota-ext4', 'ext4', d)}"

SRC_URI = "file://${LMP_FLASHLAYOUT_TEMPLATE}"

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
}

# deploy a .tar.gz file of artifacts
do_deploy() {
    install -d ${DEPLOYDIR}/${PN}
    install -m 0755 ${WORKDIR}/*.tsv ${DEPLOYDIR}/${PN}
    install -m 0755 ${DEPLOY_DIR_IMAGE}/scripts/* ${DEPLOYDIR}/${PN}
    install -m 0644 ${DEPLOY_DIR_IMAGE}/arm-trusted-firmware/*.stm32 ${DEPLOYDIR}/${PN}
    install -m 0644 ${DEPLOY_DIR_IMAGE}/fip/*.bin ${DEPLOYDIR}/${PN}
    install -m 0644 ${DEPLOY_DIR_IMAGE}/${LMP_FLASHLAYOUT_IMAGE} ${DEPLOYDIR}/${PN}/${MFGTOOL_FLASH_IMAGE}-${MACHINE}.ext4

    if [ -f "${DEPLOYDIR}/${PN}/tf-a-${LMP_FLASHLAYOUT_BOARD_NAME}-emmc.stm32" ] && \
       [ -f "${DEPLOYDIR}/${PN}/fip-${LMP_FLASHLAYOUT_BOARD_NAME}-optee.bin" ]; then
        cp ${DEPLOYDIR}/${PN}/tf-a-${LMP_FLASHLAYOUT_BOARD_NAME}-emmc.stm32 \
           ${DEPLOYDIR}/${PN}/combo-emmc-tfa-fip-${LMP_FLASHLAYOUT_BOARD_NAME}.bin
        dd if=${DEPLOYDIR}/${PN}/fip-${LMP_FLASHLAYOUT_BOARD_NAME}-optee.bin \
           of=${DEPLOYDIR}/${PN}/combo-emmc-tfa-fip-${LMP_FLASHLAYOUT_BOARD_NAME}.bin bs=1024 seek=256 conv=notrunc
    fi

    tar -czf ${DEPLOYDIR}/${PN}-${MACHINE}.tar.gz \
	    -C ${DEPLOYDIR} ${PN}

    ln -s ${PN}-${MACHINE}.tar.gz ${DEPLOYDIR}/${PN}.tar.gz
    ln -s ${PN}-${MACHINE}.tar.gz ${DEPLOYDIR}/flashlayouts-${MACHINE}.tar.gz
}

# Make sure the artifacts are deployed
do_deploy[depends] += "virtual/trusted-firmware-a:do_deploy"
do_deploy[depends] += "virtual/bootloader:do_deploy"
do_deploy[depends] += "sdcard-raw-tools-native:do_deploy"
do_deploy[depends] += "${MFGTOOL_FLASH_IMAGE}:do_image_complete"

addtask deploy after do_compile before do_build

python() {
    # we need to set the DEPENDS as well to produce valid SPDX documents
    fix_deployed_depends('do_deploy', d)
}
