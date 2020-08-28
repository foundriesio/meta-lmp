LINUX_VERSION ?= "5.4.61"

FIO_LMP_GIT_URL ?= "github.com"
FIO_LMP_GIT_NAMESPACE ?= "foundriesio/"

SRCREV_machine = "e89cbd28fe652bd7a5a525877d0098840ec91694"
SRCREV_meta = "9f43f9d2e5915a0d80a151af38273d6ec8db9680"
KBRANCH_machine = "5.4-2.1.x-imx"
KBRANCH_meta = "linux-v5.4.y"

LIC_FILES_CHKSUM = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"

SRC_URI = "git://github.com/Freescale/linux-fslc.git;protocol=https;branch=${KBRANCH_machine};name=machine; \
    git://${FIO_LMP_GIT_URL}/${FIO_LMP_GIT_NAMESPACE}lmp-kernel-cache.git;protocol=https;type=kmeta;name=meta;branch=${KBRANCH_meta};destsuffix=${KMETA} \
    file://0001-FIO-fromlist-drivers-optee-allow-op-tee-to-access-de.patch \
"

KMETA = "kernel-meta"

include recipes-kernel/linux/linux-lmp.inc
