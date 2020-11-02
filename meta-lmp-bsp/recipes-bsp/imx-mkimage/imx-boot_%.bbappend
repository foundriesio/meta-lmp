DEPENDS_remove = "optee-os"
DEPENDS += "${@bb.utils.contains('MACHINE_FEATURES', 'optee', 'virtual/optee-os', '', d)}"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_imx8mmevk = " \
     file://0001-iMX8M-support-SPL-ddr-sign.patch \
     file://0002-iMX8M-default-make-builds-SPL.patch \
"

do_compile[depends] = " \
    virtual/bootloader:do_deploy \
    ${@' '.join('%s:do_deploy' % r for r in '${IMX_EXTRA_FIRMWARE}'.split() )} \
    imx-atf:do_deploy \
    ${@bb.utils.contains('MACHINE_FEATURES', 'optee', 'virtual/optee-os:do_deploy', '', d)} \
"

compile_mx8m() {
    bbnote 8MQ/8MM/8MN/8MP boot binary build
    for ddr_firmware in ${DDR_FIRMWARE_NAME}; do
        bbnote "Copy ddr_firmware: ${ddr_firmware} from ${DEPLOY_DIR_IMAGE} -> ${BOOT_STAGING} "
        cp ${DEPLOY_DIR_IMAGE}/${ddr_firmware}               ${BOOT_STAGING}
    done
    cp ${DEPLOY_DIR_IMAGE}/signed_dp_imx8m.bin               ${BOOT_STAGING}
    cp ${DEPLOY_DIR_IMAGE}/signed_hdmi_imx8m.bin             ${BOOT_STAGING}
    cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/u-boot-spl-nodtb.bin ${BOOT_STAGING}/u-boot-spl.bin
    cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${UBOOT_DTB_NAME}   ${BOOT_STAGING}
    cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/u-boot-nodtb.bin-${MACHINE}-${UBOOT_CONFIG} \
                                                             ${BOOT_STAGING}/u-boot-nodtb.bin
    cp ${STAGING_DIR_NATIVE}/${bindir}/mkimage               ${BOOT_STAGING}/mkimage_uboot
    cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${ATF_MACHINE_NAME} ${BOOT_STAGING}/bl31.bin
    cp ${DEPLOY_DIR_IMAGE}/${UBOOT_NAME}                     ${BOOT_STAGING}/u-boot.bin
    cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/dt-spl.dtb          ${BOOT_STAGING}/u-boot-spl.dtb
}

compile_mx8() {
    bbnote 8QM boot binary build
    cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${SC_FIRMWARE_NAME} ${BOOT_STAGING}/scfw_tcm.bin
    cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${ATF_MACHINE_NAME} ${BOOT_STAGING}/bl31.bin
    cp ${DEPLOY_DIR_IMAGE}/${UBOOT_NAME}                     ${BOOT_STAGING}/u-boot.bin
    cp ${DEPLOY_DIR_IMAGE}/${SECO_FIRMWARE_NAME}             ${BOOT_STAGING}
    if [ -e ${DEPLOY_DIR_IMAGE}/u-boot-spl.bin-${MACHINE}-${UBOOT_CONFIG} ] ; then
        cp ${DEPLOY_DIR_IMAGE}/u-boot-spl.bin-${MACHINE}-${UBOOT_CONFIG} \
                                                             ${BOOT_STAGING}/u-boot-spl.bin
    fi
}

compile_mx8x() {
    bbnote 8QX boot binary build
    cp ${DEPLOY_DIR_IMAGE}/${SECO_FIRMWARE_NAME}             ${BOOT_STAGING}
    cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${SC_FIRMWARE_NAME} ${BOOT_STAGING}/scfw_tcm.bin
    cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${ATF_MACHINE_NAME} ${BOOT_STAGING}/bl31.bin
    cp ${DEPLOY_DIR_IMAGE}/${UBOOT_NAME}                     ${BOOT_STAGING}/u-boot.bin
    if [ -e ${DEPLOY_DIR_IMAGE}/u-boot-spl.bin-${MACHINE}-${UBOOT_CONFIG} ] ; then
        cp ${DEPLOY_DIR_IMAGE}/u-boot-spl.bin-${MACHINE}-${UBOOT_CONFIG} \
                                                             ${BOOT_STAGING}/u-boot-spl.bin
    fi
}

do_compile() {
    compile_${SOC_FAMILY}
    # mkimage for i.MX8
    # Copy TEE binary to SoC target folder to mkimage
    if ${DEPLOY_OPTEE}; then
        cp ${DEPLOY_DIR_IMAGE}/tee.bin ${BOOT_STAGING}
    fi
    for target in ${IMXBOOT_TARGETS}; do
        if [ "$target" = "flash_linux_m4_no_v2x" ]; then
           # Special target build for i.MX 8DXL with V2X off
           bbnote "building ${SOC_TARGET} - ${REV_OPTION} V2X=NO ${target}"
           make SOC=${SOC_TARGET} ${REV_OPTION} V2X=NO  flash_linux_m4
        else
           if [ "${MACHINE}" = "imx8mmevk" ]; then
              bbnote "building ${SOC_TARGET} - ${UBOOT_SIGN_KEYDIR} ${REV_OPTION} ${target}"
              make SOC=${SOC_TARGET} KEYDIR=${UBOOT_SIGN_KEYDIR} ${REV_OPTION} flash_spl
           else
              bbnote "building ${SOC_TARGET} - ${REV_OPTION} ${target}"
              make SOC=${SOC_TARGET} ${REV_OPTION} ${target}
	   fi
        fi
        if [ -e "${BOOT_STAGING}/flash.bin" ]; then
            cp ${BOOT_STAGING}/flash.bin ${S}/${BOOT_CONFIG_MACHINE}-${target}
            cp ${BOOT_STAGING}/flash.bin ${S}/SPL
        fi
        if [ -e "${BOOT_STAGING}/u-boot.itb" ]; then
            cp ${BOOT_STAGING}/u-boot.itb ${S}/u-boot.itb
        fi
    done
}

do_install () {
    install -d ${D}/boot
    for target in ${IMXBOOT_TARGETS}; do
        install -m 0644 ${S}/${BOOT_CONFIG_MACHINE}-${target} ${D}/boot/
	if [ -e ${S}/SPL ]; then
           install -m 0644 ${S}/SPL ${D}/boot/
	fi
	if [ -e ${S}/u-boot.itb ]; then
           install -m 0644 ${S}/u-boot.itb ${D}/boot/
	fi
    done
}

deploy_mx8m() {
    install -d ${DEPLOYDIR}/${BOOT_TOOLS}
    install -m 0644 ${DEPLOY_DIR_IMAGE}/u-boot-spl.bin-${MACHINE}-${UBOOT_CONFIG} \
                                                             ${DEPLOYDIR}/${BOOT_TOOLS}
    for ddr_firmware in ${DDR_FIRMWARE_NAME}; do
        install -m 0644 ${DEPLOY_DIR_IMAGE}/${ddr_firmware}  ${DEPLOYDIR}/${BOOT_TOOLS}
    done
    install -m 0644 ${BOOT_STAGING}/signed_dp_imx8m.bin      ${DEPLOYDIR}/${BOOT_TOOLS}
    install -m 0644 ${BOOT_STAGING}/signed_hdmi_imx8m.bin    ${DEPLOYDIR}/${BOOT_TOOLS}
    install -m 0755 ${BOOT_STAGING}/${TOOLS_NAME}            ${DEPLOYDIR}/${BOOT_TOOLS}
    install -m 0755 ${BOOT_STAGING}/mkimage_fit_atf.sh       ${DEPLOYDIR}/${BOOT_TOOLS}
    install -m 0755 ${BOOT_STAGING}/mkimage_uboot            ${DEPLOYDIR}/${BOOT_TOOLS}
}

deploy_mx8() {
    install -d ${DEPLOYDIR}/${BOOT_TOOLS}
    install -m 0644 ${BOOT_STAGING}/${SECO_FIRMWARE_NAME}    ${DEPLOYDIR}/${BOOT_TOOLS}
    install -m 0755 ${S}/${TOOLS_NAME}                       ${DEPLOYDIR}/${BOOT_TOOLS}
    if [ -e ${DEPLOY_DIR_IMAGE}/u-boot-spl.bin-${MACHINE}-${UBOOT_CONFIG} ] ; then
        install -m 0644 ${DEPLOY_DIR_IMAGE}/u-boot-spl.bin-${MACHINE}-${UBOOT_CONFIG} \
                                                             ${DEPLOYDIR}/${BOOT_TOOLS}
    fi
}

deploy_mx8x() {
    install -d ${DEPLOYDIR}/${BOOT_TOOLS}
    install -m 0644 ${BOOT_STAGING}/${SECO_FIRMWARE_NAME}    ${DEPLOYDIR}/${BOOT_TOOLS}
    install -m 0755 ${S}/${TOOLS_NAME}                       ${DEPLOYDIR}/${BOOT_TOOLS}
    if [ -e ${DEPLOY_DIR_IMAGE}/u-boot-spl.bin-${MACHINE}-${UBOOT_CONFIG} ] ; then
        install -m 0644 ${DEPLOY_DIR_IMAGE}/u-boot-spl.bin-${MACHINE}-${UBOOT_CONFIG} \
                                                             ${DEPLOYDIR}/${BOOT_TOOLS}
    fi
}

do_deploy() {
    deploy_${SOC_FAMILY}
    # copy the tool mkimage to deploy path and sc fw, dcd and uboot
    install -m 0644 ${DEPLOY_DIR_IMAGE}/${UBOOT_NAME}        ${DEPLOYDIR}/${BOOT_TOOLS}

    # copy tee.bin to deploy path
    if ${DEPLOY_OPTEE}; then
       install -m 0644 ${DEPLOY_DIR_IMAGE}/tee.bin ${DEPLOYDIR}/${BOOT_TOOLS}
    fi

    # copy makefile (soc.mak) for reference
    install -m 0644 ${BOOT_STAGING}/soc.mak                  ${DEPLOYDIR}/${BOOT_TOOLS}
    # copy the generated boot image to deploy path
    for target in ${IMXBOOT_TARGETS}; do
        # Use first "target" as IMAGE_IMXBOOT_TARGET
        if [ "$IMAGE_IMXBOOT_TARGET" = "" ]; then
            IMAGE_IMXBOOT_TARGET="$target"
            echo "Set boot target as $IMAGE_IMXBOOT_TARGET"
        fi
        install -m 0644 ${S}/${BOOT_CONFIG_MACHINE}-${target} ${DEPLOYDIR}
        if [ -e ${S}/SPL ]; then
            install -m 0644 ${S}/SPL ${DEPLOYDIR}
        fi
        if [ -e ${S}/u-boot.itb ]; then
            install -m 0644 ${S}/u-boot.itb ${DEPLOYDIR}
        fi
    done
    cd ${DEPLOYDIR}
    ln -sf ${BOOT_CONFIG_MACHINE}-${IMAGE_IMXBOOT_TARGET} ${BOOT_NAME}
    cd -
}
addtask deploy before do_build after do_compile
