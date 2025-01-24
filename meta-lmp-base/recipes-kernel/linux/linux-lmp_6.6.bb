include kmeta-linux-lmp-6.6.y.inc

LINUX_VERSION ?= "6.6.74"
KBRANCH = "linux-6.6.y"
SRCREV_machine = "00e919181a51c9154ca2cfef812ae5273688e157"
SRCREV_meta = "${KERNEL_META_COMMIT}"

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

SRC_URI = "git://github.com/foundriesio/linux.git;protocol=https;branch=${KBRANCH};name=machine; \
    ${KERNEL_META_REPO};protocol=${KERNEL_META_REPO_PROTOCOL};type=kmeta;name=meta;branch=${KERNEL_META_BRANCH};destsuffix=${KMETA} \
"

KMETA = "kernel-meta"

require linux-lmp.inc
include recipes-kernel/linux/linux-lmp-machine-custom.inc

DEFAULT_PREFERENCE = "-1"
