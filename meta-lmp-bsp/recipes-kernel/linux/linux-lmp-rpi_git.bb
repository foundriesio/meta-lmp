include recipes-kernel/linux/kmeta-linux-lmp-5.4.y.inc

LINUX_VERSION ?= "5.4.79"
KBRANCH = "rpi-5.4.y"
SRCREV_machine = "9797f1a4938c20139b00a25de93cc99efb5c291b"
SRCREV_meta = "${KERNEL_META_COMMIT}"

LIC_FILES_CHKSUM = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"

SRC_URI = "git://github.com/raspberrypi/linux.git;protocol=https;branch=${KBRANCH};name=machine; \
    ${KERNEL_META_REPO};protocol=${KERNEL_META_REPO_PROTOCOL};type=kmeta;name=meta;branch=${KERNEL_META_BRANCH};destsuffix=${KMETA} \
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
