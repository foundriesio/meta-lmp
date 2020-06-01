SUMMARY = "Linux microPlatform OSF OTA+ device registration tool"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://COPYING.MIT;md5=838c366f69b72c5df05c96dff79b35f2"

DEPENDS = "boost curl glib-2.0"

SRCREV = "c1c57815acc8f56231b90db204421df977cd4b5b"

SRC_URI = "git://github.com/foundriesio/lmp-device-register.git;protocol=https"

# Default to master tag
LMP_DEVICE_REGISTER_TAG ?= "master"

APP_TYPE ?= "${@'DOCKER_COMPOSE_APP' if d.getVar('DOCKER_COMPOSE_APP') == '1' else 'DOCKER_APPS'}"

PACKAGECONFIG ?= "aklitetags dockerapp"
PACKAGECONFIG[aklitetags] = "-DAKLITE_TAGS=ON -DDEFAULT_TAG=${LMP_DEVICE_REGISTER_TAG},-DAKLITE_TAGS=OFF,"
PACKAGECONFIG[dockerapp] = "-D${APP_TYPE}=ON,-D${APP_TYPE}=OFF,"

S = "${WORKDIR}/git"

inherit cmake

RDEPENDS_${PN} += "openssl-bin"

EXTRA_OECMAKE += "\
    ${@oe.utils.conditional('SOTA_CLIENT', 'aktualizr-lite', '-DDEVICE_API=https://api.foundries.io/ota/devices/', '', d)} \
    -DGIT_COMMIT=${SRCREV} \
    -DHARDWARE_ID=${MACHINE} \
"
