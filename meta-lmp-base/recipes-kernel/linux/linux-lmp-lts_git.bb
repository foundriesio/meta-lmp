include kmeta-linux-lmp-5.4.y.inc

LINUX_VERSION ?= "5.4.74"
KBRANCH = "linux-v5.4.y"
SRCREV_machine = "c84871b4aa1dfe75e94c3fbe88db4af5e0d71451"
SRCREV_meta = "${KERNEL_META_COMMIT}"

LIC_FILES_CHKSUM = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"

SRC_URI = "git://github.com/foundriesio/linux.git;protocol=https;branch=${KBRANCH};name=machine; \
    ${KERNEL_META_REPO};protocol=${KERNEL_META_REPO_PROTOCOL};type=kmeta;name=meta;branch=${KERNEL_META_BRANCH};destsuffix=${KMETA} \
"

KMETA = "kernel-meta"

require linux-lmp.inc
include recipes-kernel/linux/linux-lmp-machine-custom.inc
