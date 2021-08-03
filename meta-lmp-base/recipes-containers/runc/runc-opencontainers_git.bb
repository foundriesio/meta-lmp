include recipes-containers/runc/runc.inc

SRCREV = "bfcbc947d5d11327f2680047e2e6e94f4ee93d2a"
SRC_URI = " \
    git://github.com/opencontainers/runc;branch=master \
    file://0001-Makefile-respect-GOBUILDFLAGS-for-runc-and-remove-re.patch \
    "
RUNC_VERSION = "1.0.0-rc95"

CVE_PRODUCT = "runc"
