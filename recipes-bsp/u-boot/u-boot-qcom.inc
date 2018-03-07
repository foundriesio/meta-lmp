DEPENDS += "skales-native"

# set output file names
BOOT_IMAGE_BASE_NAME = "boot-${MACHINE}-${PV}-${PR}.img"
BOOT_IMAGE_SYMLINK_NAME = "boot-${MACHINE}.img"

do_deploy_append() {
    export LD_LIBRARY_PATH="$LD_LIBRARY_PATH:${STAGING_LIBDIR_NATIVE}"
    touch ${B}/empty.ramdisk
    ${STAGING_BINDIR_NATIVE}/skales/dtbTool -o ${B}/dt.img ${B}/arch/arm/dts
    ${STAGING_BINDIR_NATIVE}/skales/mkbootimg --kernel ${B}/u-boot-dtb.bin \
              --ramdisk ${B}/empty.ramdisk \
              --dt ${B}/dt.img \
              --output ${DEPLOYDIR}/${BOOT_IMAGE_BASE_NAME} \
              --pagesize ${QCOM_BOOTIMG_PAGE_SIZE} \
              --base ${QCOM_BOOTIMG_KERNEL_BASE} \
              --cmdline ""
    ln -sf ${BOOT_IMAGE_BASE_NAME} ${DEPLOYDIR}/${BOOT_IMAGE_SYMLINK_NAME}
}
