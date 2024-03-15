include kmeta-linux-lmp-6.6.y.inc

LINUX_VERSION ?= "6.6.25"
KBRANCH = "linux-6.6.y"
SRCREV_machine = "e475741af1ebe2c92ee4a3f49e55749a84770a12"
SRCREV_meta = "${KERNEL_META_COMMIT}"

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

SRC_URI = "git://github.com/foundriesio/linux.git;protocol=https;branch=${KBRANCH};name=machine; \
    ${KERNEL_META_REPO};protocol=${KERNEL_META_REPO_PROTOCOL};type=kmeta;name=meta;branch=${KERNEL_META_BRANCH};destsuffix=${KMETA} \
"

KMETA = "kernel-meta"

require linux-lmp.inc
include recipes-kernel/linux/linux-lmp-machine-custom.inc

DEFAULT_PREFERENCE = "-1"
