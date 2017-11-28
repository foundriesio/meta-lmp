LINUX_VERSION ?= "4.11.3"

SRCREV = "241905c635e97ed48885582055b19d1fea51b7f5"
OSF_LMP_GIT_URL ?= "source.foundries.io"
OSF_LMP_GIT_NAMESPACE ?= ""

SRC_URI = "git://${OSF_LMP_GIT_URL}/${OSF_LMP_GIT_NAMESPACE}linux.git;protocol=https;branch=linux-v4.11.y-dev;name=kernel \
           file://distro.scc \
"

require linux-osf.inc
require linux-osf-machine-custom.inc
