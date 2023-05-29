include recipes-containers/runc/runc.inc

SRCREV = "860f061b76bb4fc671f0f9e900f7d80ff93d4eb7"
SRC_URI = " \
    git://github.com/opencontainers/runc;branch=release-1.1;protocol=https \
    file://0001-Makefile-respect-GOBUILDFLAGS-for-runc-and-remove-re.patch \
    "
RUNC_VERSION = "1.1.7"

CVE_PRODUCT = "runc"
