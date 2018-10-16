LINUX_VERSION ?= "4.18.14"

FIO_LMP_GIT_URL ?= "source.foundries.io"
FIO_LMP_GIT_NAMESPACE ?= ""

SRCREV_machine = "6758cc13126895fe0570b9b1a0e628e3f8cc6101"
SRCREV_meta = "eea61800eaa93d1332d446d28762192df172d6f5"
KBRANCH = "linux-v4.18.y"

LIC_FILES_CHKSUM = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"

SRC_URI = "git://${FIO_LMP_GIT_URL}/${FIO_LMP_GIT_NAMESPACE}linux.git;protocol=https;branch=${KBRANCH};name=machine; \
    git://${FIO_LMP_GIT_URL}/${FIO_LMP_GIT_NAMESPACE}lmp-kernel-cache.git;protocol=https;type=kmeta;name=meta;branch=master;destsuffix=${KMETA} \
"

KMETA = "kernel-meta"

require linux-lmp.inc
require linux-lmp-machine-custom.inc
