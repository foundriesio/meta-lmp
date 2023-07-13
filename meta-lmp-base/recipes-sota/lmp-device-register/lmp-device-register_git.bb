SUMMARY = "Linux microPlatform OSF OTA+ device registration tool"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://COPYING.MIT;md5=838c366f69b72c5df05c96dff79b35f2"

DEPENDS = "boost curl glib-2.0 libp11 openssl"

SRCREV = "e3be3296f60aa03f1c0010a58f0896d3eea28882"

SRC_URI = "git://github.com/foundriesio/lmp-device-register.git;protocol=https;branch=main"

LMP_DEVICE_API ?= "https://api.foundries.io/ota/devices/"

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
    -DSOTA_CLIENT=${SOTA_CLIENT} \
"
