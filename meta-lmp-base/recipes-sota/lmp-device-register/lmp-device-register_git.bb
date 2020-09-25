SUMMARY = "Linux microPlatform OSF OTA+ device registration tool"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://COPYING.MIT;md5=838c366f69b72c5df05c96dff79b35f2"

DEPENDS = "boost curl glib-2.0"

SRCREV = "1660bfb9450b9ffc6178b777f8e074f3af9204af"

SRC_URI = "git://github.com/foundriesio/lmp-device-register.git;protocol=https"

# Default to master tag
LMP_DEVICE_REGISTER_TAG ?= "master"

PACKAGECONFIG ?= "aklitetags composeapp"
PACKAGECONFIG[aklitetags] = "-DAKLITE_TAGS=ON -DDEFAULT_TAG=${LMP_DEVICE_REGISTER_TAG},-DAKLITE_TAGS=OFF,"
PACKAGECONFIG[composeapp] = "-DDOCKER_COMPOSE_APP=ON,-DDOCKER_COMPOSE_APP=OFF,"

S = "${WORKDIR}/git"

inherit cmake

RDEPENDS_${PN} += "openssl-bin"

EXTRA_OECMAKE += "\
    ${@oe.utils.conditional('SOTA_CLIENT', 'aktualizr-lite', '-DDEVICE_API=https://api.foundries.io/ota/devices/', '', d)} \
    -DGIT_COMMIT=${SRCREV} \
    -DHARDWARE_ID=${MACHINE} \
"
