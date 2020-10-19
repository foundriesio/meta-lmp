LINUX_VERSION ?= "5.4.72"

FIO_LMP_GIT_URL ?= "github.com"
FIO_LMP_GIT_NAMESPACE ?= "foundriesio/"

SRCREV_machine = "4f8cdaa273f3e18a2ef7470c961cd2b1211dd041"
SRCREV_meta = "b507bc406a8f825e7219a24cf1539ee97f8c1993"
KBRANCH_machine = "5.4-2.1.x-imx"
KBRANCH_meta = "linux-v5.4.y"

LIC_FILES_CHKSUM = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"

SRC_URI = "git://github.com/Freescale/linux-fslc.git;protocol=https;branch=${KBRANCH_machine};name=machine; \
    git://${FIO_LMP_GIT_URL}/${FIO_LMP_GIT_NAMESPACE}lmp-kernel-cache.git;protocol=https;type=kmeta;name=meta;branch=${KBRANCH_meta};destsuffix=${KMETA} \
    file://0001-FIO-fromtree-drivers-optee-allow-op-tee-to-access-de.patch \
    file://0002-FIO-fromtree-hwrng-optee-handle-unlimited-data-rates.patch \
    file://0003-FIO-fromtree-hwrng-optee-fix-wait-use-case.patch \
    file://0004-FIO-toup-hwrng-optee-support-generic-crypto.patch \
    file://0001-FIO-fromlist-drivers-optee-i2c-add-bus-retry-configu.patch \
    file://0001-FIO-fromtree-tee-add-support-for-session-s-client-UU.patch \
    file://0002-FIO-fromtree-tee-optee-Add-support-for-session-login.patch \
    file://0001-driver-tee-Handle-NULL-pointer-indication-from-clien.patch \
"

KMETA = "kernel-meta"

include recipes-kernel/linux/linux-lmp.inc
