FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# STM32MP1 specific defines
PACKAGE_INSTALL:append:stm32mp1common = " \
    android-tools \
    android-tools-adbd \
    ${@bb.utils.contains('MACHINE_FEATURES', 'se05x', ' \
        opensc \
        softhsm \
        plug-and-trust-seteec \
        python3-plug-and-trust-ssscli', '', d)} \
"

SRC_URI:append:stm32mp1common = "\
    file://fw_env.config \
    file://start_adb.sh \
    file://tee.sh \
"

fakeroot do_populate_recovery_rootfs_custom () {
    install -m 0755 ${WORKDIR}/tee.sh ${IMAGE_ROOTFS}/recovery.d/80-tee
    # install custom recovery modules
    install -m 0755 ${WORKDIR}/start_adb.sh ${IMAGE_ROOTFS}/recovery.d/90-start_adb

    # install u-boot env config (fw_printenv / fw_setenv)
    install -m 0644 ${WORKDIR}/fw_env.config ${IMAGE_ROOTFS}/etc/

    # install system dir for adb
    install -d ${IMAGE_ROOTFS}/system/
    echo "ro.product.manufacturer=android" > ${IMAGE_ROOTFS}/system/build.prop
    echo "ro.product.model=${MACHINE}" >> ${IMAGE_ROOTFS}/system/build.prop
}

IMAGE_PREPROCESS_COMMAND:append:stm32mp1common = " do_populate_recovery_rootfs_custom; "
