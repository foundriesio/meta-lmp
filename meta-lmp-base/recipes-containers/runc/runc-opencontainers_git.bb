include recipes-containers/runc/runc.inc

SRCREV = "5fd4c4d144137e991c4acebb2146ab1483a97925"
SRC_URI = " \
    git://github.com/opencontainers/runc;branch=release-1.1;protocol=https \
    file://0001-Makefile-respect-GOBUILDFLAGS-for-runc-and-remove-re.patch \
    "
RUNC_VERSION = "1.1.4"

CVE_PRODUCT = "runc"
