SUMMARY = "NXP Plug and Trust SSS Python command line tool"
SECTION = "devel/python"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

SRC_URI = "git://github.com/foundriesio/plug-and-trust-ssscli;branch=v04.02.00;protocol=https"
SRCREV = "3c3b7ba510c32461101c66e9d790a097a2c41657"

S = "${WORKDIR}/git/src"

inherit setuptools3

RDEPENDS:${PN} += "plug-and-trust-seteec \
    ${PYTHON_PN}-click \
    ${PYTHON_PN}-logging \
    ${PYTHON_PN}-cryptography \
"

BBCLASSEXTEND = "native nativesdk"
