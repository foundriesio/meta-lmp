include recipes-kernel/linux/kmeta-linux-lmp-5.15.y.inc

LINUX_VERSION ?= "5.15.77"
KBRANCH = "toradex_5.15-2.1.x-imx"
SRCREV_machine = "3f45ee6bd117ed7f38fb4fbe66e740d7deedba1d"
SRCREV_meta = "${KERNEL_META_COMMIT}"

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

SRC_URI = "git://git.toradex.com/linux-toradex.git;protocol=git;branch=${KBRANCH};name=machine; \
    ${KERNEL_META_REPO};protocol=${KERNEL_META_REPO_PROTOCOL};type=kmeta;name=meta;branch=${KERNEL_META_BRANCH};destsuffix=${KMETA} \
"

SRC_URI:append:apalis-imx8 = " \
    file://0001-FIO-internal-Revert-ARM-dts-apalis-imx8-disable-HDMI.patch \
"

KMETA = "kernel-meta"

include recipes-kernel/linux/linux-lmp.inc

python() {
    # we need to set the DEPENDS as well to produce valid SPDX documents
    fix_deployed_depends('do_assemble_fitimage', d)
}
