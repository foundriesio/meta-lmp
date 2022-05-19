include recipes-kernel/linux/kmeta-linux-lmp-5.10.y.inc

LINUX_VERSION ?= "5.10.61"
KBRANCH = "v5.10-stm32mp"
SRCREV_machine = "64e6a220537c5cd7e8cc5b723ef09c6341388c98"
SRCREV_meta = "${KERNEL_META_COMMIT}"

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

SRC_URI = "git://github.com/STMicroelectronics/linux.git;protocol=https;branch=${KBRANCH};name=machine; \
    ${KERNEL_META_REPO};protocol=${KERNEL_META_REPO_PROTOCOL};type=kmeta;name=meta;branch=${KERNEL_META_BRANCH};destsuffix=${KMETA} \
"

KMETA = "kernel-meta"

KERNEL_EXTRA_ARGS += "LOADADDR=${ST_KERNEL_LOADADDR}"

include recipes-kernel/linux/linux-lmp.inc
