LINUX_VERSION ?= "4.16.7"

SRCREV = "313e480d7c9177decffd70321dc7c9518e841cc8"
SRCBRANCH = "linux-v4.16.y"
OSF_LMP_GIT_URL ?= "source.foundries.io"
OSF_LMP_GIT_NAMESPACE ?= ""

SRC_URI = "git://${OSF_LMP_GIT_URL}/${OSF_LMP_GIT_NAMESPACE}linux.git;protocol=https;branch=${SRCBRANCH};name=kernel \
           file://distro.scc \
           file://distro.cfg \
"

require linux-osf.inc
require linux-osf-machine-custom.inc
