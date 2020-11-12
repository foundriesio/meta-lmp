include recipes-kernel/linux/kmeta-linux-lmp-5.4.y.inc

LINUX_VERSION ?= "5.4.47"
KBRANCH = "toradex_5.4-2.1.x-imx"
SRCREV_machine = "4d47b797d6bb1db34ddf702f2cf78104be135a8f"
SRCREV_meta = "${KERNEL_META_COMMIT}"

LIC_FILES_CHKSUM = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"

SRC_URI = "git://git.toradex.com/linux-toradex.git;protocol=git;branch=${KBRANCH};name=machine; \
    ${KERNEL_META_REPO};protocol=${KERNEL_META_REPO_PROTOCOL};type=kmeta;name=meta;branch=${KERNEL_META_BRANCH};destsuffix=${KMETA} \
"

KMETA = "kernel-meta"

include recipes-kernel/linux/linux-lmp.inc

# make sure firmware-imx files are available in case they are needed by fit
do_assemble_fitimage[depends] += "${@bb.utils.contains('MACHINE_FIRMWARE', 'firmware-imx-8', 'firmware-imx-8:do_deploy', '', d)}"
