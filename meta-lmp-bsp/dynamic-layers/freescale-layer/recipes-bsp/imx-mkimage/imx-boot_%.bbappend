FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

DEPENDS_remove = "optee-os"
DEPENDS += "${@bb.utils.contains('MACHINE_FEATURES', 'optee', 'virtual/optee-os', '', d)}"


SRC_URI_append_mx8mm = " \
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

    # we copy u-boot-spl-nodtb instead of u-boot-spl.bin as we need to have
    # spl and its dtb separate, so we are able to adjust dt-spl.dtb adding
    # the signature for FIT image verification
    cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/u-boot-spl-nodtb.bin-${MACHINE}-${UBOOT_CONFIG} \
                                                             ${BOOT_STAGING}/u-boot-spl.bin
    cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/dt-spl.dtb-${MACHINE}-${UBOOT_CONFIG} \
                                                             ${BOOT_STAGING}/u-boot-spl.dtb

    cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${UBOOT_DTB_NAME}   ${BOOT_STAGING}
    cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/u-boot-nodtb.bin-${MACHINE}-${UBOOT_CONFIG} \
                                                             ${BOOT_STAGING}/u-boot-nodtb.bin
    cp ${STAGING_DIR_NATIVE}/${bindir}/mkimage               ${BOOT_STAGING}/mkimage_uboot
    cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/${ATF_MACHINE_NAME} ${BOOT_STAGING}/bl31.bin
    cp ${DEPLOY_DIR_IMAGE}/${UBOOT_NAME}                     ${BOOT_STAGING}/u-boot.bin
}

do_compile() {
    # mkimage for i.MX8
    # Copy TEE binary to SoC target folder to mkimage
    if ${DEPLOY_OPTEE}; then
        cp ${DEPLOY_DIR_IMAGE}/tee.bin ${BOOT_STAGING}
    fi
    for target in ${IMXBOOT_TARGETS}; do
        compile_${SOC_FAMILY}
        if [ "$target" = "flash_linux_m4_no_v2x" ]; then
           # Special target build for i.MX 8DXL with V2X off
           bbnote "building ${SOC_TARGET} - ${REV_OPTION} V2X=NO ${target}"
           make SOC=${SOC_TARGET} ${REV_OPTION} V2X=NO  flash_linux_m4
        else
           if [ -n "${UBOOT_SIGN_ENABLE}" ] ; then
              bbnote "building ${SOC_TARGET} - ${UBOOT_SIGN_KEYDIR} ${REV_OPTION} ${target}"
              make SOC=${SOC_TARGET} KEYDIR=${UBOOT_SIGN_KEYDIR} KEYNAME=${UBOOT_SIGN_KEYNAME} ${REV_OPTION} ${target}
           else
              bbnote "building ${SOC_TARGET} - ${REV_OPTION} ${target}"
              make SOC=${SOC_TARGET} ${REV_OPTION} ${target}
           fi
        fi
        if [ -e "${BOOT_STAGING}/flash.bin" ]; then
            if [ "$target" = "flash_spl_signed" ]; then
                 # rename to SPL
                 cp ${BOOT_STAGING}/flash.bin ${S}/SPL-${BOOT_CONFIG_MACHINE}-${target}
            else
                 cp ${BOOT_STAGING}/flash.bin ${S}/${BOOT_CONFIG_MACHINE}-${target}
            fi
        fi
        if [ -e "${BOOT_STAGING}/u-boot.itb" ]; then
            cp ${BOOT_STAGING}/u-boot.itb ${S}/u-boot.itb-${BOOT_CONFIG_MACHINE}-${target}
        fi
    done
}

do_install () {
    install -d ${D}/boot
    for target in ${IMXBOOT_TARGETS}; do
        # we don't need to copy anything to boot folder for flash_spl_signed target
        if [ "$target" != "flash_spl_signed" ]; then
             install -m 0644 ${S}/${BOOT_CONFIG_MACHINE}-${target} ${D}/boot/
        fi
    done
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
        if [ "$target" = "flash_spl_signed" ]; then
            install -m 0644 ${S}/SPL-${BOOT_CONFIG_MACHINE}-${target} ${DEPLOYDIR}
            install -m 0644 ${S}/u-boot.itb-${BOOT_CONFIG_MACHINE}-${target} ${DEPLOYDIR}
        else
            install -m 0644 ${S}/${BOOT_CONFIG_MACHINE}-${target} ${DEPLOYDIR}
        fi
    done

    # Create a symlinks with relative paths, needed for final WIC image creation
    cd ${DEPLOYDIR}
    if [ "$target" = "flash_spl_signed" ]; then
        ln -sf SPL-${BOOT_CONFIG_MACHINE}-${IMAGE_IMXBOOT_TARGET} SPL
        ln -sf u-boot.itb-${BOOT_CONFIG_MACHINE}-${IMAGE_IMXBOOT_TARGET} u-boot.itb
        # Creating links for mfgtools scripts
        ln -sf SPL-${BOOT_CONFIG_MACHINE}-${IMAGE_IMXBOOT_TARGET} SPL-${MACHINE}
        ln -sf u-boot.itb-${BOOT_CONFIG_MACHINE}-${IMAGE_IMXBOOT_TARGET} u-boot-${MACHINE}.itb
    else
        # imx-boot symlink
        install -m 0644 ${S}/${BOOT_CONFIG_MACHINE}-${target} ${BOOT_NAME}
    fi
    cd -
}
