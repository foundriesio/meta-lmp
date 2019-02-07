SUMMARY = "Linux microPlatform OSF OTA+ device registration tool"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://COPYING.MIT;md5=838c366f69b72c5df05c96dff79b35f2"

DEPENDS = "boost curl ostree glib-2.0"

SRCREV = "927a262d872e60c74226a4612a16ae14e7f01260"

SRC_URI = "git://github.com/foundriesio/lmp-device-register.git;protocol=https"

S = "${WORKDIR}/git"

inherit cmake

RDEPENDS_${PN} += "openssl-bin"
