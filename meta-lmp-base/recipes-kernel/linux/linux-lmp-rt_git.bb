include kmeta-linux-lmp-5.15.y.inc

LINUX_VERSION ?= "5.15.55"
KBRANCH = "linux-v5.15.y-rt"
SRCREV_machine = "aa3db6be10576f50e75f521d6114a67079fee8e6"
SRCREV_meta = "${KERNEL_META_COMMIT}"
LINUX_KERNEL_TYPE = "preempt-rt"

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

SRC_URI = "git://github.com/foundriesio/linux.git;protocol=https;branch=${KBRANCH};name=machine; \
    ${KERNEL_META_REPO};protocol=${KERNEL_META_REPO_PROTOCOL};type=kmeta;name=meta;branch=${KERNEL_META_BRANCH};destsuffix=${KMETA} \
"

KMETA = "kernel-meta"

require linux-lmp.inc
include recipes-kernel/linux/linux-lmp-machine-custom.inc
