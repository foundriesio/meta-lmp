# To enable this recipe, set PREFERRED_PROVIDER_virtual/kernel = "linux-lmp-dev"
# in conf/auto.conf or conf/local.conf.
#
# In order to build a custom revision/tree, define your own KERNEL_* variables

python __anonymous() {
    if "linux-lmp-dev" not in d.getVar("PREFERRED_PROVIDER_virtual/kernel"):
        msg = "Skipping linux-lmp-dev as it is not the preferred provider of virtual/kernel."
        raise bb.parse.SkipRecipe(msg)
}

FIO_LMP_GIT_URL ?= "github.com"
FIO_LMP_GIT_NAMESPACE ?= "foundriesio/"

LINUX_VERSION ?= "6.5.0-rc2"
LINUX_VERSION_EXTENSION ?= "-lmpdev-${LINUX_KERNEL_TYPE}"
PV = "${LINUX_VERSION}+git"

KERNEL_REPO ?= "git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git"
KERNEL_REPO_PROTOCOL ?= "https"
KERNEL_BRANCH ?= "master"
KERNEL_COMMIT ?= "${AUTOREV}"
KERNEL_META_REPO ?= "git://${FIO_LMP_GIT_URL}/${FIO_LMP_GIT_NAMESPACE}lmp-kernel-cache.git"
KERNEL_META_REPO_PROTOCOL ?= "https"
KERNEL_META_BRANCH ?= "master"
KERNEL_META_COMMIT ?= "${AUTOREV}"
KERNEL_VERSION_SANITY_SKIP = "1"

SRCREV_machine = "${KERNEL_COMMIT}"
SRCREV_meta = "${KERNEL_META_COMMIT}"

LIC_FILES_CHKSUM ?= "file://COPYING;md5=6bc538ed5bd9a7fc9398086aedcd7e46"

SRC_URI = "${KERNEL_REPO};protocol=${KERNEL_REPO_PROTOCOL};branch=${KERNEL_BRANCH};name=machine; \
           ${KERNEL_META_REPO};protocol=${KERNEL_META_REPO_PROTOCOL};type=kmeta;name=meta;branch=${KERNEL_META_BRANCH};destsuffix=${KMETA}"

KMETA = "kernel-meta"

require linux-lmp.inc
include recipes-kernel/linux/linux-lmp-machine-custom.inc
