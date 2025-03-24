include recipes-kernel/linux/kmeta-linux-lmp-6.6.y.inc

LINUX_VERSION ?= "6.6.63"
KBRANCH = "rpi-6.6.y"
SRCREV_machine = "e442e5c1ab6bff5b5460b4fc949beb72aaf77970"
SRCREV_meta = "${KERNEL_META_COMMIT}"

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

SRC_URI = "git://github.com/raspberrypi/linux.git;protocol=https;branch=${KBRANCH};name=machine; \
    ${KERNEL_META_REPO};protocol=${KERNEL_META_REPO_PROTOCOL};type=kmeta;name=meta;branch=${KERNEL_META_BRANCH};destsuffix=${KMETA} \
"

KMETA = "kernel-meta"

include recipes-kernel/linux/linux-lmp.inc

KERNEL_DTC_FLAGS += "-@ -H epapr"
