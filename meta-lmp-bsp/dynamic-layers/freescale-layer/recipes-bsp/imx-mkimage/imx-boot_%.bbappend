FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

DEPENDS:remove = "optee-os"
DEPENDS += "${@bb.utils.contains('MACHINE_FEATURES', 'optee', 'virtual/optee-os', '', d)}"

M33_DEFAULT_IMAGE:mx8ulp-nxp-bsp = "imx8ulp_m33_TCM_power_mode_switch.bin"

SRC_URI:append:mx8m-nxp-bsp = " \
     file://0002-iMX8M-add-SPL-only-build.patch \
     file://0003-iMX8M-add-support-for-packing-HDMI-fw-in-SPL-only-bo.patch \
     file://0004-iMX8M-also-create-nohdmi-boot-image.patch \
     file://0001-iMX8M-change-DDR-DMEM-padding.patch \
     file://0001-iMX8M-add-SPL-only-build-for-DDR4.patch \
"

SRC_URI:append:mx8qm-nxp-bsp = " \
     file://0001-iMX8QM-add-SPL-only-build.patch \
"
SRC_URI:append:mx8ulp-nxp-bsp = " \
     file://0001-iMX8ULP-add-SPL-only-build.patch \
"
SRC_URI:append:mx93-nxp-bsp = " \
     file://0001-iMX9-add-SPL-only-build.patch \
"

do_compile[depends] = " \
    virtual/bootloader:do_deploy \
    ${@' '.join('%s:do_deploy' % r for r in '${IMX_EXTRA_FIRMWARE}'.split() )} \
    imx-atf:do_deploy \
    ${@bb.utils.contains('MACHINE_FEATURES', 'optee', 'virtual/optee-os:do_deploy', '', d)} \
"

do_compile:prepend:mx8ulp-nxp-bsp() {
    if [ -f ${DEPLOY_DIR_IMAGE}/${M33_DEFAULT_IMAGE} ]; then
        cp ${DEPLOY_DIR_IMAGE}/${M33_DEFAULT_IMAGE} ${BOOT_STAGING}/m33_image.bin
    fi
}

copy_uboot_spl() {
    # copy u-boot-spl-nodtb instead of u-boot-spl.bin as we need to have
    # spl and its dtb separate (dt-spl.dtb will contain public hash of
    # used to check the signature of u-boot fit-image)
    cp ${DEPLOY_DIR_IMAGE}/${BOOT_TOOLS}/u-boot-spl-nodtb.bin-${MACHINE}-${UBOOT_CONFIG} \
                                                         ${BOOT_STAGING}/u-boot-spl-nodtb.bin
    cp ${DEPLOY_DIR_IMAGE}/u-boot-spl.bin-${MACHINE}.dtb ${BOOT_STAGING}/u-boot-spl.dtb
}
SIGNED_IMX8M_FW = "signed_hdmi_imx8m.bin signed_dp_imx8m.bin"
do_compile:prepend:mx8-nxp-bsp() {
    copy_uboot_spl

    for signedfw in ${SIGNED_IMX8M_FW}; do
        if [ -e "${DEPLOY_DIR_IMAGE}/${signedfw}" ]; then
            cp ${DEPLOY_DIR_IMAGE}/${signedfw} ${BOOT_STAGING}/${signedfw}
        fi
    done
}
do_compile:prepend:mx93-nxp-bsp() {
    copy_uboot_spl
}

do_compile:append() {
    for type in ${UBOOT_CONFIG}; do
        UBOOT_CONFIG_EXTRA="$type"
        BOOT_CONFIG_MACHINE_EXTRA="${BOOT_NAME}-${MACHINE}-${UBOOT_CONFIG_EXTRA}.bin"
        for target in ${IMXBOOT_TARGETS}; do
            if [ -e "${BOOT_STAGING}/flash.bin-nohdmi" ]; then
                cp ${BOOT_STAGING}/flash.bin-nohdmi ${S}/${BOOT_CONFIG_MACHINE_EXTRA}-${target}-nohdmi
            fi
        done
    done
}

do_install:append() {
    for type in ${UBOOT_CONFIG}; do
        UBOOT_CONFIG_EXTRA="$type"
        BOOT_CONFIG_MACHINE_EXTRA="${BOOT_NAME}-${MACHINE}-${UBOOT_CONFIG_EXTRA}.bin"
        for target in ${IMXBOOT_TARGETS}; do
            if [ -e "${S}/${BOOT_CONFIG_MACHINE_EXTRA}-${target}-nohdmi" ]; then
                install -m 0644 ${S}/${BOOT_CONFIG_MACHINE_EXTRA}-${target}-nohdmi ${D}/boot/
            fi
        done
    done
}

do_deploy:append() {
    for type in ${UBOOT_CONFIG}; do
        UBOOT_CONFIG_EXTRA="$type"
        BOOT_CONFIG_MACHINE_EXTRA="${BOOT_NAME}-${MACHINE}-${UBOOT_CONFIG_EXTRA}.bin"
        for target in ${IMXBOOT_TARGETS}; do
            if [ -e "${S}/${BOOT_CONFIG_MACHINE_EXTRA}-${target}-nohdmi" ]; then
                install -m 0644 ${S}/${BOOT_CONFIG_MACHINE_EXTRA}-${target}-nohdmi ${DEPLOYDIR}
                if [ ! -e "${DEPLOYDIR}/${BOOT_NAME}-${MACHINE}-nohdmi" ]; then
                    ln -sf ${BOOT_CONFIG_MACHINE_EXTRA}-${IMAGE_IMXBOOT_TARGET}-nohdmi ${DEPLOYDIR}/${BOOT_NAME}-nohdmi
                    ln -sf ${BOOT_CONFIG_MACHINE_EXTRA}-${IMAGE_IMXBOOT_TARGET}-nohdmi ${DEPLOYDIR}/${BOOT_NAME}-${MACHINE}-nohdmi
                fi
            fi
        done

        # Also create imx-boot link with the machine name (with the default IMXBOOT_TARGET)
        if [ ! -e "${DEPLOYDIR}/${BOOT_NAME}-${MACHINE}" ]; then
            ln -sf ${BOOT_CONFIG_MACHINE_EXTRA}-${IMAGE_IMXBOOT_TARGET} ${DEPLOYDIR}/${BOOT_NAME}-${MACHINE}
        fi
    done
}
