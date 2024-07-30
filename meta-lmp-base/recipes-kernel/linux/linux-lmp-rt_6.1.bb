include kmeta-linux-lmp-6.1.y.inc

LINUX_VERSION ?= "6.1.102"
KBRANCH = "linux-v6.1.y-rt"
SRCREV_machine = "7a6baf05f5707c0e0329be0fd1d9620b0f98ca55"
SRCREV_meta = "${KERNEL_META_COMMIT}"
LINUX_KERNEL_TYPE = "preempt-rt"

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

SRC_URI = "git://github.com/foundriesio/linux.git;protocol=https;branch=${KBRANCH};name=machine; \
    ${KERNEL_META_REPO};protocol=${KERNEL_META_REPO_PROTOCOL};type=kmeta;name=meta;branch=${KERNEL_META_BRANCH};destsuffix=${KMETA} \
"

KMETA = "kernel-meta"

require linux-lmp.inc
include recipes-kernel/linux/linux-lmp-machine-custom.inc
