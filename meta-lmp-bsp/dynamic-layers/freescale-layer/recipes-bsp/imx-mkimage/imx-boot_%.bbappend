FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

DEPENDS_remove = "optee-os"
DEPENDS += "${@bb.utils.contains('MACHINE_FEATURES', 'optee', 'virtual/optee-os', '', d)}"


SRC_URI_append_mx8m = " \
     file://0001-iMX8M-support-SPL-ddr-sign.patch \
     file://0002-iMX8M-add-SPL-only-build.patch \
     file://0003-iMX8M-add-support-for-packing-HDMI-fw-in-SPL-only-bo.patch \
"

do_compile[depends] = " \
    virtual/bootloader:do_deploy \
    ${@' '.join('%s:do_deploy' % r for r in '${IMX_EXTRA_FIRMWARE}'.split() )} \
    imx-atf:do_deploy \
    ${@bb.utils.contains('MACHINE_FEATURES', 'optee', 'virtual/optee-os:do_deploy', '', d)} \
"

do_compile_prepend_mx8m() {
    SECONDARY_OFFSET=$(printf "%d" $(grep -e CONFIG_SECONDARY_BOOT_SECTOR_OFFSET ${DEPLOY_DIR_IMAGE}/u-boot-fio-config | sed 's/=/ /g' | awk '{print $2}'))
    if [ "${SECONDARY_OFFSET}" != "0" ]; then
        # Use existing sit_gen.sh script to generate Secondary Image Table
        bbnote "Building Secondary Image Table, firstSectorNumber = ${SECONDARY_OFFSET}"
        ${S}/scripts/gen_sit.sh ${SECONDARY_OFFSET}
    fi
    if [ "${IMXBOOT_TARGETS}" = "flash_evk_spl" ]; then
        # copy u-boot-spl-nodtb instead of u-boot-spl.bin as we need to have
        # spl and its dtb separate (dt-spl.dtb will contain public hash of
        # used to check the signature of u-boot fit-image)
        cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/u-boot-spl-nodtb.bin-${MACHINE}-${UBOOT_CONFIG} \
                                                             ${BOOT_STAGING}/u-boot-spl-nodtb.bin
        cp ${DEPLOY_DIR_IMAGE}/u-boot-spl.bin-${MACHINE}.dtb ${BOOT_STAGING}/u-boot-spl.dtb
        if [ -e "${DEPLOY_DIR_IMAGE}/signed_hdmi_imx8m.bin" ]; then
            cp ${DEPLOY_DIR_IMAGE}/signed_hdmi_imx8m.bin ${BOOT_STAGING}/signed_hdmi_imx8m.bin
        fi
    fi
}

do_deploy_append() {
    # Also create imx-boot link with the machine name
    ln -sf ${BOOT_CONFIG_MACHINE}-${IMAGE_IMXBOOT_TARGET} ${DEPLOYDIR}/${BOOT_NAME}-${MACHINE}
    if [ -f ${S}/sit.bin ]; then
        install -m 0644 ${S}/sit.bin ${DEPLOYDIR}/sit-${MACHINE}.bin
    fi
}
