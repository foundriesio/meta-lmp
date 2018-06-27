LINUX_VERSION ?= "4.16.18"

SRCREV = "0a7619473e7896f83d26872254eea443d21c4b22"
SRCBRANCH = "linux-v4.16.y"
OSF_LMP_GIT_URL ?= "source.foundries.io"
OSF_LMP_GIT_NAMESPACE ?= ""

SRC_URI = "git://${OSF_LMP_GIT_URL}/${OSF_LMP_GIT_NAMESPACE}linux.git;protocol=https;branch=${SRCBRANCH};name=kernel \
           file://distro.scc \
           file://distro.cfg \
"

require linux-osf.inc
require linux-osf-machine-custom.inc
