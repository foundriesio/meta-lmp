SUMMARY = "Linux microPlatform OSF OTA+ device registration tool"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://COPYING.MIT;md5=838c366f69b72c5df05c96dff79b35f2"

DEPENDS = "boost curl glib-2.0"

SRCREV = "633b11b397b996f2bce2438324db203879b9ffda"

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
