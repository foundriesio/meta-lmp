include recipes-kernel/linux/kmeta-linux-lmp-5.4.y.inc

LINUX_VERSION ?= "5.4.104"
KBRANCH = "5.4-2.1.x-imx"
SRCREV_machine = "589addeb80a052531a84b2d1817d71d1987fa0d9"
SRCREV_meta = "${KERNEL_META_COMMIT}"

LIC_FILES_CHKSUM = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"

SRC_URI = "git://github.com/Freescale/linux-fslc.git;protocol=https;branch=${KBRANCH};name=machine; \
    ${KERNEL_META_REPO};protocol=${KERNEL_META_REPO_PROTOCOL};type=kmeta;name=meta;branch=${KERNEL_META_BRANCH};destsuffix=${KMETA} \
    file://0001-FIO-fromtree-drivers-optee-allow-op-tee-to-access-de.patch \
    file://0002-FIO-fromtree-hwrng-optee-handle-unlimited-data-rates.patch \
    file://0003-FIO-fromtree-hwrng-optee-fix-wait-use-case.patch \
    file://0004-FIO-toup-hwrng-optee-support-generic-crypto.patch \
    file://0001-FIO-fromlist-drivers-optee-i2c-add-bus-retry-configu.patch \
    file://0001-FIO-fromtree-tee-add-support-for-session-s-client-UU.patch \
    file://0002-FIO-fromtree-tee-optee-Add-support-for-session-login.patch \
    file://0001-driver-tee-Handle-NULL-pointer-indication-from-clien.patch \
    file://0001-FIO-fromtree-ath10k-add-QCA9377-sdio-hw_param-item.patch \
"

KMETA = "kernel-meta"

include recipes-kernel/linux/linux-lmp.inc
