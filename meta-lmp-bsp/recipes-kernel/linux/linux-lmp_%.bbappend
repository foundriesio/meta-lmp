FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}/${KSHORT_VER}:${THISDIR}/${PN}:"

SRC_URI:append:stm32mp15-disco = " \
    ${@bb.utils.contains('MACHINE_FEATURES', 'se05x', "file://0001-FIO-internal-arch-arm-dts-stm32mp157c-dk2-enable-I2C.patch", '', d)} \
"
