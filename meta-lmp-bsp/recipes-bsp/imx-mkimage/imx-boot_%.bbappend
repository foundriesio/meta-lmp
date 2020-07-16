DEPENDS_remove = "optee-os"
DEPENDS += "${@bb.utils.contains('MACHINE_FEATURES', 'optee', 'virtual/optee-os', '', d)}"

do_compile[depends] = " \
    virtual/bootloader:do_deploy \
    ${@' '.join('%s:do_deploy' % r for r in '${IMX_EXTRA_FIRMWARE}'.split() )} \
    imx-atf:do_deploy \
    ${@bb.utils.contains('MACHINE_FEATURES', 'optee', 'virtual/optee-os:do_deploy', '', d)} \
"

# 8QM (e.g. apalis-imx8)
SRCBRANCH_apalis-imx8 = "imx_4.14.98_2.3.0"
SRCREV_apalis-imx8 = "d7f9440dd5c050cc22cb362d53d4048e689a0c01"
SECO_CHIP ?= "qm"
SECO_CHIP_apalis-imx8 = "qmb0"
SECO_FIRMWARE = "mx8${SECO_CHIP}-ahab-container.img"
REV_CHIP ?= "B0"

compile_mx8() {
    bbnote 8QM boot binary build
    cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${SC_FIRMWARE_NAME} ${BOOT_STAGING}/scfw_tcm.bin
    cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${ATF_MACHINE_NAME} ${BOOT_STAGING}/bl31.bin
    cp ${DEPLOY_DIR_IMAGE}/${UBOOT_NAME}                     ${BOOT_STAGING}/u-boot.bin
    cp ${DEPLOY_DIR_IMAGE}/${SECO_FIRMWARE}                  ${BOOT_STAGING}
}

deploy_mx8() {
    install -d ${DEPLOYDIR}/${BOOT_TOOLS}
    install -m 0644 ${BOOT_STAGING}/${SECO_FIRMWARE} ${DEPLOYDIR}/${BOOT_TOOLS}
    install -m 0755 ${S}/${TOOLS_NAME}               ${DEPLOYDIR}/${BOOT_TOOLS}
}

do_compile_apalis-imx8() {
    # mkimage_uboot requires libssl.so.1.1 from ${STAGING_LIBDIR_NATIVE}
    export LD_LIBRARY_PATH=${STAGING_LIBDIR_NATIVE}:$LD_LIBRARY_PATH
    compile_${SOC_FAMILY}
    # mkimage for i.MX8
    if ${DEPLOY_OPTEE}; then
        cp ${DEPLOY_DIR_IMAGE}/tee.bin ${BOOT_STAGING}
    fi
    for target in ${IMXBOOT_TARGETS}; do
        bbnote "building ${SOC_TARGET} - ${target}"
        make SOC=${SOC_TARGET} REV=${REV_CHIP} dtbs=${UBOOT_DTB_NAME} ${target}
        if [ -e "${BOOT_STAGING}/flash.bin" ]; then
            cp ${BOOT_STAGING}/flash.bin ${S}/${BOOT_CONFIG_MACHINE}-${target}
        fi
    done
}
