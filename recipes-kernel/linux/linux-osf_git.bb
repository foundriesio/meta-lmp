LINUX_VERSION ?= "4.14.16"

SRCREV = "3d887da3b2dde8c3f6fb80a9a9d24d3fb1726177"
OSF_LMP_GIT_URL ?= "source.foundries.io"
OSF_LMP_GIT_NAMESPACE ?= ""

SRC_URI = "git://${OSF_LMP_GIT_URL}/${OSF_LMP_GIT_NAMESPACE}linux.git;protocol=https;branch=linux-v4.14.y;name=kernel \
           file://distro.scc \
"

require linux-osf.inc
require linux-osf-machine-custom.inc
