include recipes-kernel/linux/kmeta-linux-lmp-5.4.y.inc

LINUX_VERSION ?= "5.4.129"
KBRANCH = "toradex_5.4-2.3.x-imx"
SRCREV_machine = "09dedcf8e8301c81290944fec7f46498a6057fb6"
SRCREV_meta = "${KERNEL_META_COMMIT}"

LIC_FILES_CHKSUM = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"

SRC_URI = "git://git.toradex.com/linux-toradex.git;protocol=git;branch=${KBRANCH};name=machine; \
    ${KERNEL_META_REPO};protocol=${KERNEL_META_REPO_PROTOCOL};type=kmeta;name=meta;branch=${KERNEL_META_BRANCH};destsuffix=${KMETA} \
"

SRC_URI_append_apalis-imx8 = " \
    file://0001-FIO-internal-Revert-ARM-dts-apalis-imx8-disable-HDMI.patch \
    file://0001-FIO-internal-arm64-dts-apalis-imx8-ixora-v1.2-enable.patch \
"

KMETA = "kernel-meta"

include recipes-kernel/linux/linux-lmp.inc

# make sure firmware-imx files are available in case they are needed by fit
do_assemble_fitimage[depends] += "${@bb.utils.contains('MACHINE_FIRMWARE', 'firmware-imx-8', 'firmware-imx-8:do_deploy', '', d)}"
