include recipes-containers/runc/runc.inc

SRCREV = "82f18fe0e44a59034f3e1f45e475fa5636e539aa"
SRC_URI = " \
    git://github.com/opencontainers/runc;branch=release-1.1;protocol=https \
    file://0001-Makefile-respect-GOBUILDFLAGS-for-runc-and-remove-re.patch \
    "
RUNC_VERSION = "1.1.8"

CVE_PRODUCT = "runc"
