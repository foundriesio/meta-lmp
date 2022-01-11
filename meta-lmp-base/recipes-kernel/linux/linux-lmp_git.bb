LINUX_VERSION ?= "5.4.167"

FIO_LMP_GIT_URL ?= "github.com"
FIO_LMP_GIT_NAMESPACE ?= "foundriesio/"

SRCREV_machine = "25e04114e75ec644afaa6373c96b40d49711f058"
SRCREV_meta = "a8fcb1d22dd1986dc8590e4ecd044699b007cbde"
KBRANCH = "linux-v5.4.y"

LIC_FILES_CHKSUM = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"

SRC_URI = "git://${FIO_LMP_GIT_URL}/${FIO_LMP_GIT_NAMESPACE}linux.git;protocol=https;branch=${KBRANCH};name=machine; \
    git://${FIO_LMP_GIT_URL}/${FIO_LMP_GIT_NAMESPACE}lmp-kernel-cache.git;protocol=https;type=kmeta;name=meta;branch=${KBRANCH};destsuffix=${KMETA} \
"

KMETA = "kernel-meta"

require linux-lmp.inc
include recipes-kernel/linux/linux-lmp-machine-custom.inc
