DESCRIPTION = "A PKCS#11 Test Suite"
HOMEPAGE = "https://github.com/google/pkcs11test"
SECTION = "tests"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=175792518e4ac015ab6696d16c4f607e"

SRC_URI = "git://github.com/foundriesio/pkcs11test.git;protocol=https;branch=dev"
SRCREV = "57e1652b1995566e3f33bfa955856d7d0797cc83"

S = "${WORKDIR}/git"

do_compile() {
    oe_runmake
}

do_install() {
    install -d ${D}${bindir}
    install -m 0755 ${S}/pkcs11test ${D}${bindir}
}
