LINUX_VERSION ?= "4.16.18"

FIO_LMP_GIT_URL ?= "source.foundries.io"
FIO_LMP_GIT_NAMESPACE ?= ""

SRCREV_machine = "0a7619473e7896f83d26872254eea443d21c4b22"
SRCREV_meta = "9b6bde200242cc2ee9b0cfccd2f4374243bfdf8f"
KBRANCH = "linux-v4.16.y"

SRC_URI = "git://${FIO_LMP_GIT_URL}/${FIO_LMP_GIT_NAMESPACE}linux.git;protocol=https;branch=${KBRANCH};name=machine; \
    git://${FIO_LMP_GIT_URL}/${FIO_LMP_GIT_NAMESPACE}lmp-kernel-cache.git;protocol=https;type=kmeta;name=meta;branch=master;destsuffix=${KMETA} \
"

KMETA = "kernel-meta"

require linux-lmp.inc
require linux-lmp-machine-custom.inc
