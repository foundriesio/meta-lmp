include recipes-kernel/linux/kmeta-linux-lmp-5.10.y.inc

LINUX_VERSION ?= "5.10.72"
KBRANCH = "linux-ea-v5.10.72"
SRCREV_machine = "5fd902d8b4c81932ff2b46e4b19b3a02aa947be6"
SRCREV_meta = "${KERNEL_META_COMMIT}"

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

SRC_URI = "git://github.com/foundriesio/linux.git;protocol=https;branch=${KBRANCH};name=machine; \
    ${KERNEL_META_REPO};protocol=${KERNEL_META_REPO_PROTOCOL};type=kmeta;name=meta;branch=${KERNEL_META_BRANCH};destsuffix=${KMETA} \
"

KMETA = "kernel-meta"

include recipes-kernel/linux/linux-lmp.inc
