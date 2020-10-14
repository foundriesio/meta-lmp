LINUX_VERSION ?= "5.4.47"

FIO_LMP_GIT_URL ?= "github.com"
FIO_LMP_GIT_NAMESPACE ?= "foundriesio/"

SRCREV_machine = "4149b00f27c531c9af1de941007665ecb80dbb75"
SRCREV_meta = "8795790ddd89349e09de05924d8b8bd99eb07b6f"
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
