LINUX_VERSION ?= "4.14.14"

SRCREV = "795eab06451f841725f1bc83f8b65156b1a86eb3"
OSF_LMP_GIT_URL ?= "source.foundries.io"
OSF_LMP_GIT_NAMESPACE ?= ""

SRC_URI = "git://${OSF_LMP_GIT_URL}/${OSF_LMP_GIT_NAMESPACE}linux.git;protocol=https;branch=linux-v4.14.y;name=kernel \
           file://distro.scc \
"

require linux-osf.inc
require linux-osf-machine-custom.inc
