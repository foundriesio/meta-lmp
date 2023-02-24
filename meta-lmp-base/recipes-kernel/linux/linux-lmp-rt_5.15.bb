include kmeta-linux-lmp-5.15.y.inc

LINUX_VERSION ?= "5.15.94"
KBRANCH = "linux-v5.15.y-rt"
SRCREV_machine = "077d8aac57a04a0267cad1a8c20f6ffcfb093cc4"
SRCREV_meta = "${KERNEL_META_COMMIT}"
LINUX_KERNEL_TYPE = "preempt-rt"

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

SRC_URI = "git://github.com/foundriesio/linux.git;protocol=https;branch=${KBRANCH};name=machine; \
    ${KERNEL_META_REPO};protocol=${KERNEL_META_REPO_PROTOCOL};type=kmeta;name=meta;branch=${KERNEL_META_BRANCH};destsuffix=${KMETA} \
"

KMETA = "kernel-meta"

require linux-lmp.inc
include recipes-kernel/linux/linux-lmp-machine-custom.inc
