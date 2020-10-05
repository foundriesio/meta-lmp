LINUX_VERSION ?= "5.4.47"

FIO_LMP_GIT_URL ?= "github.com"
FIO_LMP_GIT_NAMESPACE ?= "foundriesio/"

SRCREV_machine = "9e7307657fc1b86fc652abd32676b516fc28fe23"
SRCREV_meta = "b507bc406a8f825e7219a24cf1539ee97f8c1993"
KBRANCH_machine = "toradex_5.4-2.1.x-imx"
KBRANCH_meta = "linux-v5.4.y"

LIC_FILES_CHKSUM = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"

SRC_URI = "git://git.toradex.com/linux-toradex.git;protocol=git;branch=${KBRANCH_machine};name=machine; \
    git://${FIO_LMP_GIT_URL}/${FIO_LMP_GIT_NAMESPACE}lmp-kernel-cache.git;protocol=https;type=kmeta;name=meta;branch=${KBRANCH_meta};destsuffix=${KMETA} \
"

KMETA = "kernel-meta"

include recipes-kernel/linux/linux-lmp.inc

# make sure firmware-imx files are available in case they are needed by fit
do_assemble_fitimage[depends] += "${@bb.utils.contains('MACHINE_FIRMWARE', 'firmware-imx-8', 'firmware-imx-8:do_deploy', '', d)}"
