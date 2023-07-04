SUMMARY = "Output IMA/EVM extended attributes in a human readable format"
LICENSE = "GPL-2.0-or-later"
LIC_FILES_CHKSUM = "file://LICENSE;md5=a23a74b3f4caf9616230789d94217acb"

DEPENDS += "attr ima-evm-utils tclap"

SRC_URI = "git://github.com/mgerstner/ima-inspect.git;protocol=https;branch=master"
SRCREV = "2e248ce53728f5b2bfc34a934a19636b84f8eb88"

S = "${WORKDIR}/git"

inherit autotools pkgconfig
