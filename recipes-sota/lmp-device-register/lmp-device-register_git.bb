SUMMARY = "Linux microPlatform OSF OTA+ device registration tool"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://COPYING.MIT;md5=838c366f69b72c5df05c96dff79b35f2"

DEPENDS = "boost curl ostree glib-2.0"

SRCREV = "dcc7df7a6c1e1fbc9c1aa62377421ba6b457dfe0"
FIO_LMP_GIT_URL ?= "github.com"
FIO_LMP_GIT_NAMESPACE ?= "foundriesio/"

SRC_URI = "git://${FIO_LMP_GIT_URL}/${FIO_LMP_GIT_NAMESPACE}lmp-device-register.git;protocol=https"

S = "${WORKDIR}/git"

inherit cmake

RDEPENDS_${PN} += "openssl-bin"
