LINUX_VERSION ?= "5.4.31"

FIO_LMP_GIT_URL ?= "github.com"
FIO_LMP_GIT_NAMESPACE ?= "foundriesio/"

SRCREV_machine = "58fc5c504721a0a73aca0ee7651e63c2b1645c9b"
SRCREV_meta = "438cd3c6aa055af7acd99bac3c88469b792b9e6a"
KBRANCH = "linux-v5.4.y"

LIC_FILES_CHKSUM = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"

SRC_URI = "git://${FIO_LMP_GIT_URL}/${FIO_LMP_GIT_NAMESPACE}linux.git;protocol=https;branch=${KBRANCH};name=machine; \
    git://${FIO_LMP_GIT_URL}/${FIO_LMP_GIT_NAMESPACE}lmp-kernel-cache.git;protocol=https;type=kmeta;name=meta;branch=${KBRANCH};destsuffix=${KMETA} \
"

KMETA = "kernel-meta"

require linux-lmp.inc
include recipes-kernel/linux/linux-lmp-machine-custom.inc
