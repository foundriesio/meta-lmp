SUMMARY = "Linux microPlatform OSF OTA+ device registration tool"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://COPYING.MIT;md5=838c366f69b72c5df05c96dff79b35f2"

DEPENDS = "boost curl glib-2.0"

SRCREV = "3fb49bb5659377c63469fc9a49d6ab7d65bab702"

SRC_URI = "git://github.com/foundriesio/lmp-device-register.git;protocol=https;branch=master"

# Defaults to the public factory
LMP_DEVICE_REGISTER_TAG ?= "master"
LMP_DEVICE_FACTORY ?= "lmp"
LMP_DEVICE_API ?= "https://api.foundries.io/ota/devices/"

PACKAGECONFIG ?= "aklitetags composeapp"
PACKAGECONFIG[aklitetags] = "-DAKLITE_TAGS=ON -DDEFAULT_TAG=${LMP_DEVICE_REGISTER_TAG},-DAKLITE_TAGS=OFF,"
PACKAGECONFIG[composeapp] = "-DDOCKER_COMPOSE_APP=ON,-DDOCKER_COMPOSE_APP=OFF,"
PACKAGECONFIG[production] = "-DPRODUCTION=ON,-DPRODUCTION=OFF,"

S = "${WORKDIR}/git"

inherit cmake

RDEPENDS_${PN} += "openssl-bin ${SOTA_CLIENT}"

EXTRA_OECMAKE += "\
    -DGIT_COMMIT=${SRCREV} \
    -DHARDWARE_ID=${MACHINE} \
    -DDEVICE_FACTORY=${LMP_DEVICE_FACTORY} \
    -DDEVICE_API=${LMP_DEVICE_API} \
    -DSOTA_CLIENT=${SOTA_CLIENT} \
"
