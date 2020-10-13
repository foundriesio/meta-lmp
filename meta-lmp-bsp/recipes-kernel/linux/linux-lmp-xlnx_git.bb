LINUX_VERSION ?= "5.4.0"

FIO_LMP_GIT_URL ?= "github.com"
FIO_LMP_GIT_NAMESPACE ?= "foundriesio/"

SRCREV_machine = "ebece0e2eab7ce2dfd7ec9d263a6744fc3f6fb24"
SRCREV_meta = "b507bc406a8f825e7219a24cf1539ee97f8c1993"
KBRANCH_machine = "xlnx_rebase_v5.4"
KBRANCH_meta = "linux-v5.4.y"

LIC_FILES_CHKSUM = "file://COPYING;md5=bbea815ee2795b2f4230826c0c6b8814"

SRC_URI = "git://github.com/Xilinx/linux-xlnx.git;protocol=https;branch=${KBRANCH_machine};name=machine; \
    git://${FIO_LMP_GIT_URL}/${FIO_LMP_GIT_NAMESPACE}lmp-kernel-cache.git;protocol=https;type=kmeta;name=meta;branch=${KBRANCH_meta};destsuffix=${KMETA} \
    file://0001-FIO-fromtree-tee-add-support-for-session-s-client-UU.patch \
    file://0002-FIO-fromtree-tee-optee-Add-support-for-session-login.patch \
    file://0001-driver-tee-Handle-NULL-pointer-indication-from-clien.patch \
"

KMETA = "kernel-meta"

include recipes-kernel/linux/linux-lmp.inc
