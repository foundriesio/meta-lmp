SUMMARY = "Linux microPlatform OSF OTA+ device registration tool"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://COPYING.MIT;md5=838c366f69b72c5df05c96dff79b35f2"

DEPENDS = "boost curl ostree glib-2.0"

SRCREV = "13f65a2756331b157e3aecdedcc734e60b80311c"

SRC_URI = "git://github.com/foundriesio/lmp-device-register.git;protocol=https"

# Default to master tag
LMP_DEVICE_REGISTER_TAG ?= "master"

PACKAGECONFIG ?= "aklitetags dockerapp"
PACKAGECONFIG[aklitetags] = "-DAKLITE_TAGS=ON -DDEFAULT_TAG=${LMP_DEVICE_REGISTER_TAG},-DAKLITE_TAGS=OFF,"
PACKAGECONFIG[dockerapp] = "-DDOCKER_APPS=ON,-DDOCKER_APPS=OFF,"

S = "${WORKDIR}/git"

inherit cmake

RDEPENDS_${PN} += "openssl-bin"

EXTRA_OECMAKE += "\
    ${@oe.utils.conditional('SOTA_CLIENT', 'aktualizr-lite', '-DDEVICE_API=https://api.foundries.io/ota/devices/', '', d)} \
    -DGIT_COMMIT=${SRCREV} \
    -DHARDWARE_ID=${MACHINE} \
"
