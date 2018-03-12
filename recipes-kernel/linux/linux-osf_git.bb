LINUX_VERSION ?= "4.14.26"

SRCREV = "179474290134d6b15b709b50ea4ec3137a490702"
OSF_LMP_GIT_URL ?= "source.foundries.io"
OSF_LMP_GIT_NAMESPACE ?= ""

SRC_URI = "git://${OSF_LMP_GIT_URL}/${OSF_LMP_GIT_NAMESPACE}linux.git;protocol=https;branch=linux-v4.14.y;name=kernel \
           file://distro.scc \
           file://distro.cfg \
"

require linux-osf.inc
require linux-osf-machine-custom.inc
