include recipes-kernel/linux/kmeta-linux-lmp-5.4.y.inc

LINUX_VERSION ?= "5.4.134"
KBRANCH = "5.4-2.3.x-imx"
SRCREV_machine = "e3b082933caab27829e775606708381fe1b7c3ba"
SRCREV_meta = "${KERNEL_META_COMMIT}"

LIC_FILES_CHKSUM = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"

SRC_URI = "git://github.com/Freescale/linux-fslc.git;protocol=https;branch=${KBRANCH};name=machine; \
    ${KERNEL_META_REPO};protocol=${KERNEL_META_REPO_PROTOCOL};type=kmeta;name=meta;branch=${KERNEL_META_BRANCH};destsuffix=${KMETA} \
    file://0001-FIO-fromtree-drivers-optee-allow-op-tee-to-access-de.patch \
    file://0002-FIO-fromtree-hwrng-optee-handle-unlimited-data-rates.patch \
    file://0003-FIO-fromtree-hwrng-optee-fix-wait-use-case.patch \
    file://0004-FIO-toup-hwrng-optee-support-generic-crypto.patch \
    file://0001-FIO-fromlist-drivers-optee-i2c-add-bus-retry-configu.patch \
    file://0001-FIO-fromtree-ath10k-add-QCA9377-sdio-hw_param-item.patch \
    file://0001-FIO-extras-arm64-dts-imx8mm-evk-use-imx8mm-evkb-for-.patch \
"

KMETA = "kernel-meta"

include recipes-kernel/linux/linux-lmp.inc
