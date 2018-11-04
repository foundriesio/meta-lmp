LINUX_VERSION ?= "4.18.16"

FIO_LMP_GIT_URL ?= "source.foundries.io"
FIO_LMP_GIT_NAMESPACE ?= ""

SRCREV_machine = "8aa5b3d9ce421799f541e6dc3b81ae206c6d5e24"
SRCREV_meta = "b15a38120a74e117938321c996e04484567e6e6d"
KBRANCH = "linux-v4.18.y"

LIC_FILES_CHKSUM = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"

SRC_URI = "git://${FIO_LMP_GIT_URL}/${FIO_LMP_GIT_NAMESPACE}linux.git;protocol=https;branch=${KBRANCH};name=machine; \
    git://${FIO_LMP_GIT_URL}/${FIO_LMP_GIT_NAMESPACE}lmp-kernel-cache.git;protocol=https;type=kmeta;name=meta;branch=master;destsuffix=${KMETA} \
"

KMETA = "kernel-meta"

require linux-lmp.inc
require linux-lmp-machine-custom.inc
