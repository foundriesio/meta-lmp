SUMMARY = "Output IMA/EVM extended attributes in a human readable format"
LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://LICENSE;md5=a23a74b3f4caf9616230789d94217acb"

DEPENDS += "attr ima-evm-utils tclap"

SRC_URI = "git://github.com/mgerstner/ima-inspect.git;protocol=https;branch=master"
SRCREV = "05db29b37965366cba22abe5e4de545e439cb4f2"

S = "${WORKDIR}/git"

inherit autotools pkgconfig
