LINUX_VERSION ?= "4.14.33"

SRCREV = "d493633d497ecc4a9a167f1bedf2e16254190afc"
OSF_LMP_GIT_URL ?= "source.foundries.io"
OSF_LMP_GIT_NAMESPACE ?= ""

SRC_URI = "git://${OSF_LMP_GIT_URL}/${OSF_LMP_GIT_NAMESPACE}linux.git;protocol=https;branch=linux-v4.14.y;name=kernel \
           file://distro.scc \
           file://distro.cfg \
"

require linux-osf.inc
require linux-osf-machine-custom.inc
