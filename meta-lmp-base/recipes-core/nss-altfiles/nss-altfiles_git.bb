SUMMARY = "NSS module which can read user information from files in an alternative location"
LICENSE = "LGPL-2.1-only"
LIC_FILES_CHKSUM = "file://COPYING;md5=fb1949d8d807e528c1673da700aff41f"

# Use upstream used and maintained by Flatcar
SRC_URI = "git://github.com/kinvolk/nss-altfiles.git;protocol=https;branch=master"

PV = "2.23.0+git"
SRCREV = "9078c543ba7d2bc5011737675b3dddb882673ce7"

S = "${WORKDIR}/git"

inherit autotools-brokensep

NSS_ALT_TYPES ?= "pwd,grp,spwd,sgrp"

EXTRA_OECONF = " \
    --datadir=${libdir} \
    --prefix=${libdir} \
    --with-types=${NSS_ALT_TYPES} \
"
