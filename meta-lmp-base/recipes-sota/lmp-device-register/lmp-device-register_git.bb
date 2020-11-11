SUMMARY = "Linux microPlatform OSF OTA+ device registration tool"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://COPYING.MIT;md5=838c366f69b72c5df05c96dff79b35f2"

DEPENDS = "boost curl glib-2.0"

SRCREV = "b59e76abb303fbaf85d1621426c5523536e21d20"

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
