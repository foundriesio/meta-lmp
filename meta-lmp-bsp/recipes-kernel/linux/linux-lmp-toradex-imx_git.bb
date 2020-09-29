LINUX_VERSION ?= "5.4.47"

FIO_LMP_GIT_URL ?= "github.com"
FIO_LMP_GIT_NAMESPACE ?= "foundriesio/"

SRCREV_machine = "4a17940e35ceb1802f62cae3bbf1e8212c46d188"
SRCREV_meta = "a53196f49c7120a9505c7ebe45d663e5d581e1dc"
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
