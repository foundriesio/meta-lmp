include recipes-kernel/linux/kmeta-linux-lmp-6.1.y.inc

# Use Freescale kernel by default
KERNEL_REPO ?= "git://github.com/Freescale/linux-fslc.git"
KERNEL_REPO_PROTOCOL ?= "https"
LINUX_VERSION ?= "6.1.24"
KERNEL_BRANCH ?= "6.1-1.0.x-imx"

SRCREV_machine = "8842a4d0ef55bb3d7561566c79b28f45ac76f863"
SRCREV_meta = "${KERNEL_META_COMMIT}"

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

SRC_URI = "${KERNEL_REPO};protocol=${KERNEL_REPO_PROTOCOL};branch=${KERNEL_BRANCH};name=machine; \
    ${KERNEL_META_REPO};protocol=${KERNEL_META_REPO_PROTOCOL};type=kmeta;name=meta;branch=${KERNEL_META_BRANCH};destsuffix=${KMETA} \
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

KMETA = "kernel-meta"

include recipes-kernel/linux/linux-lmp.inc

DEFAULT_PREFERENCE = "-1"
