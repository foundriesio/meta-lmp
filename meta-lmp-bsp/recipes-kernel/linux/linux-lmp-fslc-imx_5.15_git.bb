include recipes-kernel/linux/kmeta-linux-lmp-5.15.y.inc

# Use Freescale kernel by default
KERNEL_REPO ?= "git://github.com/Freescale/linux-fslc.git"
KERNEL_REPO_PROTOCOL ?= "https"
LINUX_VERSION ?= "5.15.77"
KERNEL_BRANCH ?= "5.15-2.1.x-imx"

SRCREV_machine = "9dcc132b0caa04022a9adbb76510258684fbfef7"
SRCREV_meta = "${KERNEL_META_COMMIT}"

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}/5.15:"

SRC_URI = "${KERNEL_REPO};protocol=${KERNEL_REPO_PROTOCOL};branch=${KERNEL_BRANCH};name=machine; \
    ${KERNEL_META_REPO};protocol=${KERNEL_META_REPO_PROTOCOL};type=kmeta;name=meta;branch=${KERNEL_META_BRANCH};destsuffix=${KMETA} \
    file://0004-FIO-toup-hwrng-optee-support-generic-crypto.patch \
    file://0001-FIO-extras-arm64-dts-imx8mm-evk-use-imx8mm-evkb-for-.patch \
    file://0001-arm64-dts-imx8mq-drop-cpu-idle-states.patch \
    file://0001-FIO-fromlist-gpu-drm-imx-sec_mipi_dsim-imx-fix-probe.patch \
"

SRC_URI:append:imx8mp-lpddr4-evk = " \
    ${@bb.utils.contains('MACHINE_FEATURES', 'se05x', 'file://0001-FIO-internal-arch-arm64-dts-imx8mp-enable-I2C5-bus.patch', '', d)} \
"

# Add bluetooth support for QCA9377
SRC_URI:append:imx8mm-lpddr4-evk = " \
    file://0001-FIO-toup-arm64-dts-imx8mm-evk-qca-wifi-enable-suppor.patch \
"
# Fix bluetooth reset for Murata 1MW
SRC_URI:append:imx8mn-ddr4-evk = " \
    file://0001-FIO-internal-arm64-dts-imx8mn-evk.dtsi-re-add-blueto.patch \
"

KMETA = "kernel-meta"

DEFAULT_PREFERENCE = "-1"

include recipes-kernel/linux/linux-lmp.inc
