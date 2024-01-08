include recipes-containers/runc/runc.inc

SRCREV = "ccaecfcbc907d70a7aa870a6650887b901b25b82"
SRC_URI = " \
    git://github.com/opencontainers/runc;branch=release-1.1;protocol=https \
    file://0001-Makefile-respect-GOBUILDFLAGS-for-runc-and-remove-re.patch \
    "
RUNC_VERSION = "1.1.9"

CVE_PRODUCT = "runc"
