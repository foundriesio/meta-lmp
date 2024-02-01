include recipes-containers/runc/runc.inc

SRCREV = "51d5e94601ceffbbd85688df1c928ecccbfa4685"
SRC_URI = " \
    git://github.com/opencontainers/runc;branch=release-1.1;protocol=https \
    file://0001-Makefile-respect-GOBUILDFLAGS-for-runc-and-remove-re.patch \
    "
RUNC_VERSION = "1.1.12"

CVE_PRODUCT = "runc"
