LINUX_VERSION ?= "5.4.72"

FIO_LMP_GIT_URL ?= "github.com"
FIO_LMP_GIT_NAMESPACE ?= "foundriesio/"

SRCREV_machine = "154de7bbd5844a824a635d4f9e3f773c15c6ce11"
SRCREV_meta = "acdc8d2b023e268c8d3f83588fe1ead836006c54"
KBRANCH_machine = "rpi-5.4.y"
KBRANCH_meta = "linux-v5.4.y"

LIC_FILES_CHKSUM = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"

SRC_URI = "git://github.com/raspberrypi/linux.git;protocol=https;branch=${KBRANCH_machine};name=machine; \
    git://${FIO_LMP_GIT_URL}/${FIO_LMP_GIT_NAMESPACE}lmp-kernel-cache.git;protocol=https;type=kmeta;name=meta;branch=${KBRANCH_meta};destsuffix=${KMETA} \
    file://0001-arm-overlays-vc4-kms-v3d-overlay-restore-back-cma-ch.patch \
"

KMETA = "kernel-meta"

include recipes-kernel/linux/linux-lmp.inc

## Required to generate correct dtb files
do_compile_append() {
    if [ "${SITEINFO_BITS}" = "64" ]; then
        cc_extra=$(get_cc_option)
        oe_runmake dtbs CC="${KERNEL_CC} $cc_extra " LD="${KERNEL_LD}" ${KERNEL_EXTRA_ARGS}
    fi
}
