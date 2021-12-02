include recipes-kernel/linux/kmeta-linux-lmp-5.10.y.inc

# Use Freescale kernel by default
KERNEL_REPO ?= "git://github.com/Freescale/linux-fslc.git"
KERNEL_REPO_PROTOCOL ?= "https"
LINUX_VERSION ?= "5.10.80"
KERNEL_BRANCH ?= "5.10-2.1.x-imx"

SRCREV_machine = "c0604ebbd45934a2c42df8382b674244d1963fa2"
SRCREV_meta = "${KERNEL_META_COMMIT}"

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

SRC_URI = "${KERNEL_REPO};protocol=${KERNEL_REPO_PROTOCOL};branch=${KERNEL_BRANCH};name=machine; \
    ${KERNEL_META_REPO};protocol=${KERNEL_META_REPO_PROTOCOL};type=kmeta;name=meta;branch=${KERNEL_META_BRANCH};destsuffix=${KMETA} \
    file://0004-FIO-toup-hwrng-optee-support-generic-crypto.patch \
    file://0001-FIO-extras-arm64-dts-imx8mm-evk-use-imx8mm-evkb-for-.patch \
    file://0001-FIO-tonxp-drm-bridge-it6161-add-missing-gpio-consume.patch \
    file://0001-arm64-dts-imx8mq-drop-cpu-idle-states.patch \
    file://0001-FIO-temphack-ARM-mach-imx-conditionally-disable-some.patch \
"

KMETA = "kernel-meta"

include recipes-kernel/linux/linux-lmp.inc
