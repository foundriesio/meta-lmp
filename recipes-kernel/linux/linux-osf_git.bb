LINUX_VERSION ?= "4.16.8"

SRCREV = "1b517a37694c27bc7e6b8cbcc77d7570b8785a42"
SRCBRANCH = "linux-v4.16.y"
OSF_LMP_GIT_URL ?= "source.foundries.io"
OSF_LMP_GIT_NAMESPACE ?= ""

SRC_URI = "git://${OSF_LMP_GIT_URL}/${OSF_LMP_GIT_NAMESPACE}linux.git;protocol=https;branch=${SRCBRANCH};name=kernel \
           file://distro.scc \
           file://distro.cfg \
"

require linux-osf.inc
require linux-osf-machine-custom.inc
