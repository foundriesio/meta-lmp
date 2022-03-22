include recipes-containers/runc/runc.inc

SRCREV = "e0124d569cb2dfe93bd9fb8d7f4ade461e006464"
SRC_URI = " \
    git://github.com/opencontainers/runc;branch=release-1.0;protocol=https \
    file://0001-Makefile-respect-GOBUILDFLAGS-for-runc-and-remove-re.patch \
    "
RUNC_VERSION = "1.0.3"

CVE_PRODUCT = "runc"
