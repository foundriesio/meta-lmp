# Define config for each TF_A_CONFIG
#   TF_A_CONFIG[config] ?= "<list of devicetree>,<extra opt flags>,<binary basename (default: 'tf-a')>,<make target (default: 'all')>,<type of binary to deploy: [bl2 bl31 bl32 fwconfig] (default 'bl2')>"

TF_A_CONFIG[optee]  ?= "${STM32MP_DEVICETREE},AARCH32_SP=optee,,${@bb.utils.contains('FIP_BL31_ENABLE', '1', 'bl31 dtbs', 'dtbs', d)},${@bb.utils.contains('FIP_BL31_ENABLE', '1', 'bl31 fwconfig', 'fwconfig', d)}"
TF_A_CONFIG[trusted] ?= "${@' '.join(d for d in '${STM32MP_DEVICETREE}'.split() if 'stm32mp15' in d)},AARCH32_SP=sp_min,,bl32 dtbs,bl32 fwconfig"

TF_A_CONFIG[serialboot] ?= "${STM32MP_DEVICETREE},AARCH32_SP=sp_min STM32MP_UART_PROGRAMMER=1 STM32MP_USB_PROGRAMMER=1 STM32MP_USE_STM32IMAGE=1"

TF_A_CONFIG[emmc]    ?= "${DEVICE_BOARD_ENABLE:EMMC},STM32MP_EMMC=1 STM32MP_EMMC_BOOT=1 ${@bb.utils.contains('MACHINE_FEATURES', 'fw-update', 'PSA_FWU_SUPPORT=1', '', d)}"
TF_A_CONFIG[nand]    ?= "${DEVICE_BOARD_ENABLE:NAND},STM32MP_RAW_NAND=1 ${@'STM32MP_FORCE_MTD_START_OFFSET=${TF_A_MTD_START_OFFSET_NAND}' if ${TF_A_MTD_START_OFFSET_NAND} else ''}"
TF_A_CONFIG[nor]     ?= "${DEVICE_BOARD_ENABLE:NOR},STM32MP_SPI_NOR=1 ${@bb.utils.contains('MACHINE_FEATURES', 'fw-update', 'PSA_FWU_SUPPORT=1', '', d)} ${@'STM32MP_FORCE_MTD_START_OFFSET=${TF_A_MTD_START_OFFSET_NOR}' if ${TF_A_MTD_START_OFFSET_NOR} else ''}"
TF_A_CONFIG[sdcard]  ?= "${DEVICE_BOARD_ENABLE:SDCARD},STM32MP_SDMMC=1 ${@bb.utils.contains('MACHINE_FEATURES', 'fw-update', 'PSA_FWU_SUPPORT=1', '', d)}"
TF_A_CONFIG[spinand] ?= "${DEVICE_BOARD_ENABLE:SPINAND},STM32MP_SPI_NAND=1 ${@'STM32MP_FORCE_MTD_START_OFFSET=${TF_A_MTD_START_OFFSET_SPINAND}' if ${TF_A_MTD_START_OFFSET_SPINAND} else ''}"
TF_A_CONFIG[uart]    ?= "${STM32MP_DEVICETREE},STM32MP_UART_PROGRAMMER=1"
TF_A_CONFIG[usb]     ?= "${STM32MP_DEVICETREE},STM32MP_USB_PROGRAMMER=1"

# Define configuration for SSP
TF_A_CONFIG[uart-ssp] ?= "${STM32MP_DEVICETREE},STM32MP_UART_PROGRAMMER=1 STM32MP_SSP=1,tf-a-ssp"
TF_A_CONFIG[usb-ssp]  ?= "${STM32MP_DEVICETREE},STM32MP_USB_PROGRAMMER=1 STM32MP_SSP=1,tf-a-ssp"

TFA_PLATFORM  = "stm32mp1"
TF_A_SUFFIX   = "stm32"
TF_A_METADATA_JSON ?= "plat/st/stm32mp1/default_metadata.json"
TF_A_SOC_NAME  = "${STM32MP_SOC_NAME}"

sign_binaries() {
    STM32MP_SIGNINGTOOL="${STM32_CUBE_PATH}/bin/STM32MP_SigningTool_CLI"
    if ! [ -f "${STM32MP_SIGNINGTOOL}" ]; then
        bbfatal "Fail to sign TF-A BL2 binaries, as the STM32MP Signing Tool CLI not found at '${STM32MP_SIGNINGTOOL}'. \nThe STM32_CUBE_PATH variables are not set correctly"
    fi
    unset i
    for config in ${TF_A_CONFIG}; do
        i=$(expr $i + 1)

        # Initialize devicetree list and tf-a basename
        dt_config=$(echo ${TF_A_DEVICETREE} | cut -d',' -f${i})
        tfa_basename=$(echo ${TF_A_BINARIES} | cut -d',' -f${i})
        tfa_file_type=$(echo ${TF_A_FILES} | cut -d',' -f${i})
        for dt in ${dt_config}; do
            # Init soc suffix
            soc_suffix=""
            if [ -n "${TF_A_SOC_NAME}" ]; then
                for soc in ${TF_A_SOC_NAME}; do
                    [ "$(echo ${dt} | grep -c ${soc})" -eq 1 ] && soc_suffix="-${soc}"
                done
            fi
            for file_type in ${tfa_file_type}; do
                if [ "${file_type}" = "bl2" ]; then
                    # Install TF-A binary
                    config_src="${B}/${config}${soc_suffix}/${tfa_basename}-${dt}-${config}"
                    bbnote "Signing STM32 TF-A binary with ROT key: ${config_src}.${TF_A_SUFFIX}"
                    ${STM32MP_SIGNINGTOOL} -bin "${config_src}.${TF_A_SUFFIX}" \
                        -pubk ${STM32_ROT_KEY_PATH}/publicKey.pem -prvk ${STM32_ROT_KEY_PATH}/privateKey.pem \
                        -iv 5 -t fsbl -pwd ${STM32_ROT_KEY_PASSWORD} --silent
                    install -m 644 "${config_src}_Signed.${TF_A_SUFFIX}" "${DEPLOYDIR}/arm-trusted-firmware"
                fi
            done
        done
    done
}

TF_A_DEPLOY_POSTFUNC ?= ""
TF_A_DEPLOY_POSTFUNC:stm32mp15-eval-sec = "sign_binaries"
TF_A_DEPLOY_POSTFUNC:stm32mp15-disco-sec = "sign_binaries"

create_combo_image() {
    if [ -f "${DEPLOYDIR}/arm-trusted-firmware/tf-a-${LMP_FLASHLAYOUT_BOARD_NAME}-emmc_Signed.stm32" ] && \
       [ -f "${DEPLOYDIR}/fip/fip-${LMP_FLASHLAYOUT_BOARD_NAME}-optee.bin" ]; then
        cp ${DEPLOYDIR}/arm-trusted-firmware/tf-a-${LMP_FLASHLAYOUT_BOARD_NAME}-emmc_Signed.stm32 \
           ${DEPLOYDIR}/fip/combo-emmc-tfa-fip-${LMP_FLASHLAYOUT_BOARD_NAME}.bin
        dd if=${DEPLOYDIR}/fip/fip-${LMP_FLASHLAYOUT_BOARD_NAME}-optee.bin \
           of=${DEPLOYDIR}/fip/combo-emmc-tfa-fip-${LMP_FLASHLAYOUT_BOARD_NAME}.bin bs=1024 seek=256 conv=notrunc
    else
        if [ -f "${DEPLOYDIR}/arm-trusted-firmware/tf-a-${LMP_FLASHLAYOUT_BOARD_NAME}-emmc.stm32" ] && \
           [ -f "${DEPLOYDIR}/fip/fip-${LMP_FLASHLAYOUT_BOARD_NAME}-optee.bin" ]; then
            cp ${DEPLOYDIR}/arm-trusted-firmware/tf-a-${LMP_FLASHLAYOUT_BOARD_NAME}-emmc.stm32 \
               ${DEPLOYDIR}/fip/combo-emmc-tfa-fip-${LMP_FLASHLAYOUT_BOARD_NAME}.bin
            dd if=${DEPLOYDIR}/fip/fip-${LMP_FLASHLAYOUT_BOARD_NAME}-optee.bin \
               of=${DEPLOYDIR}/arm-trusted-firmware/combo-emmc-tfa-fip-${LMP_FLASHLAYOUT_BOARD_NAME}.bin bs=1024 seek=256 conv=notrunc
        fi
    fi
}

do_deploy[postfuncs] += "${@bb.utils.contains('STM32_ROT_SIGN_ENABLE', '1', '${TF_A_DEPLOY_POSTFUNC}', '', d)} create_combo_image"
