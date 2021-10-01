include recipes-kernel/linux/kmeta-linux-lmp-5.10.y.inc

LINUX_VERSION ?= "5.10.52"
KBRANCH = "lf-5.10.y"
SRCREV_machine = "a11753a89ec610768301d4070e10b8bd60fde8cd"
SRCREV_meta = "${KERNEL_META_COMMIT}"

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

SRC_URI = "git://source.codeaurora.org/external/imx/linux-imx.git;protocol=https;branch=${KBRANCH};name=machine; \
    ${KERNEL_META_REPO};protocol=${KERNEL_META_REPO_PROTOCOL};type=kmeta;name=meta;branch=${KERNEL_META_BRANCH};destsuffix=${KMETA} \
    file://0004-FIO-toup-hwrng-optee-support-generic-crypto.patch \
    file://0001-FIO-extras-arm64-dts-imx8mm-evk-use-imx8mm-evkb-for-.patch \
    file://0001-FIO-tonxp-drm-bridge-it6161-add-missing-gpio-consume.patch \
"

KMETA = "kernel-meta"

include recipes-kernel/linux/linux-lmp.inc
