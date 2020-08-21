LINUX_VERSION ?= "5.8.1"

FIO_LMP_GIT_URL ?= "github.com"
FIO_LMP_GIT_NAMESPACE ?= "foundriesio/"

SRCREV_machine = "04de5f0decda01b5a372cbb732d538ea4ba838cd"
SRCREV_meta = "084df9c24be9a036589984d9b258aa55dbf41ba4"
KBRANCH = "linux-v5.8.y"

LIC_FILES_CHKSUM = "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

SRC_URI = "git://${FIO_LMP_GIT_URL}/${FIO_LMP_GIT_NAMESPACE}linux.git;protocol=https;branch=${KBRANCH};name=machine; \
    git://${FIO_LMP_GIT_URL}/${FIO_LMP_GIT_NAMESPACE}lmp-kernel-cache.git;protocol=https;type=kmeta;name=meta;branch=${KBRANCH};destsuffix=${KMETA} \
"

KMETA = "kernel-meta"

require linux-lmp.inc
include recipes-kernel/linux/linux-lmp-machine-custom.inc
