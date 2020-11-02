FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

BOOT_TOOLS_mx8 = "imx-boot-tools"

# From u-boot-imx/meta-freescale
do_deploy_append_mx8m() {
    # Deploy u-boot-nodtb.bin and XX.dtb for mkimage to generate boot binary
    if [ -n "${UBOOT_CONFIG}" ]; then
        for config in ${UBOOT_MACHINE}; do
            i=$(expr $i + 1);
            for type in ${UBOOT_CONFIG}; do
                j=$(expr $j + 1);
                if [ $j -eq $i ]; then
                    install -d ${DEPLOYDIR}/${BOOT_TOOLS}
                    # When sign is enabled the final DTB should be copied from deploy dir
                    if [ "${UBOOT_SIGN_ENABLE}" = "1" ]; then
                        install -m 0644 ${DEPLOY_DIR_IMAGE}/${UBOOT_DTB_IMAGE} ${DEPLOYDIR}/${BOOT_TOOLS}/${UBOOT_DTB_NAME}
                    else
                        install -m 0644 ${B}/${config}/arch/arm/dts/${UBOOT_DTB_NAME} ${DEPLOYDIR}/${BOOT_TOOLS}
                    fi
                    install -m 0644 ${B}/${config}/dts/dt-spl.dtb ${DEPLOYDIR}/${BOOT_TOOLS}
		    install -m 0644 ${B}/${config}/spl/u-boot-spl-nodtb.bin ${DEPLOYDIR}/${BOOT_TOOLS}
                    install -m 0644 ${B}/${config}/u-boot-nodtb.bin ${DEPLOYDIR}/${BOOT_TOOLS}/u-boot-nodtb.bin-${MACHINE}-${UBOOT_CONFIG}
                fi
            done
            unset  j
        done
        unset  i
    fi
}
