include recipes-kernel/linux/linux-lmp-fslc-imx.inc

include recipes-kernel/linux/kmeta-linux-lmp-5.15.y.inc

LINUX_VERSION ?= "5.15.87"
KERNEL_BRANCH ?= "5.15-2.2.x-imx"

SRCREV_machine = "0eb4504bd3b8fd125e83ec62da9ba039519f96c8"

SRC_URI += "\
    file://0004-FIO-toup-hwrng-optee-support-generic-crypto.patch \
    file://0001-FIO-extras-arm64-dts-imx8mm-evk-use-imx8mm-evkb-for-.patch \
    file://0001-arm64-dts-imx8mq-drop-cpu-idle-states.patch \
"

SRC_URI:append:imx8mp-lpddr4-evk = " \
    ${@bb.utils.contains('MACHINE_FEATURES', 'se05x', 'file://0001-FIO-internal-arch-arm64-dts-imx8mp-enable-I2C5-bus.patch', '', d)} \
"

# Add bluetooth support for QCA9377
SRC_URI:append:imx8mm-lpddr4-evk = " \
    file://0001-FIO-toup-arm64-dts-imx8mm-evk-qca-wifi-enable-suppor.patch \
"
# Fix bluetooth reset for Murata 1MW
SRC_URI:append:mx8mn-nxp-bsp = " \
    file://0001-FIO-internal-arm64-dts-imx8mn-evk.dtsi-re-add-blueto.patch \
"
