SUMMARY = "Linux microPlatform OSF OTA+ device registration tool"
HOMEPAGE = "https://github.com/foundriesio/lmp-device-register"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://COPYING.MIT;md5=838c366f69b72c5df05c96dff79b35f2"

DEPENDS = "boost curl glib-2.0 libp11 openssl"

SRCREV = "d8f39a6d95e20f5b64881ae014381682aa1c7aad"

SRC_URI = "git://github.com/foundriesio/lmp-device-register.git;protocol=https;branch=main \
    file://0001-pkcs11-revert-libp11-0.4.16-keygen-API.patch \
"

LMP_DEVICE_API ?= "https://api.foundries.io/ota/devices/"
LMP_OAUTH_API ?= "https://app.foundries.io/oauth"

PACKAGECONFIG ?= "composeapp"
PACKAGECONFIG[composeapp] = "-DDOCKER_COMPOSE_APP=ON,-DDOCKER_COMPOSE_APP=OFF,"
PACKAGECONFIG[production] = "-DPRODUCTION=ON,-DPRODUCTION=OFF,"

S = "${WORKDIR}/git"

inherit cmake pkgconfig

RDEPENDS:${PN} += "${SOTA_CLIENT}"

EXTRA_OECMAKE += "\
    -DGIT_COMMIT=${SRCREV} \
    -DHARDWARE_ID=${MACHINE} \
    -DDEVICE_API=${LMP_DEVICE_API} \
    -DOAUTH_API=${LMP_OAUTH_API} \
    -DSOTA_CLIENT=${SOTA_CLIENT} \
    -DREQUIRE_FACTORY=ON \
"
