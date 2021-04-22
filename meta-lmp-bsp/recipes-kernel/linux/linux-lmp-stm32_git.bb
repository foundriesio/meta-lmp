include recipes-kernel/linux/kmeta-linux-lmp-5.4.y.inc

LINUX_VERSION ?= "5.4.56"
KBRANCH = "v5.4-stm32mp"
SRCREV_machine = "e1b933d6960ad6412d6ab2961dcd394dd1234bf4"
SRCREV_meta = "${KERNEL_META_COMMIT}"

LIC_FILES_CHKSUM = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"

SRC_URI = "git://github.com/STMicroelectronics/linux.git;protocol=https;branch=${KBRANCH};name=machine; \
    ${KERNEL_META_REPO};protocol=${KERNEL_META_REPO_PROTOCOL};type=kmeta;name=meta;branch=${KERNEL_META_BRANCH};destsuffix=${KMETA} \
"

KMETA = "kernel-meta"

include recipes-kernel/linux/linux-lmp.inc
