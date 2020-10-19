DESCRIPTION = "A simple recipe to deliver flashlayout files for STM32MP1 platforms"
HOMEPAGE = "https://st.com"
SECTION = "base"
LICENSE = "MPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MPL-2.0;md5=815ca599c9df247a0c7f619bab123dad"

inherit deploy

SRC_URI = "file://FlashLayout_emmc_stm32mp157a-ev1-trusted.tsv.in"

do_compile() {
    sed -e 's/@@IMAGE@@/${IMAGE}/' ${WORKDIR}/${LMP_FLASHLAYOUT}.in > ${WORKDIR}/${LMP_FLASHLAYOUT}
}

do_deploy() {
    install -m 0644 ${WORKDIR}/${LMP_FLASHLAYOUT} ${DEPLOYDIR}
}

addtask do_deploy after do_compile before do_build
