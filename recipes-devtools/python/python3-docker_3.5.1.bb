SUMMARY = "A Python library for the Docker Engine API."
HOMEPAGE = "https://github.com/docker/docker-py"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=34f3846f940453127309b920eeb89660"

inherit pypi setuptools3

SRC_URI[md5sum] = "496237b9e0826eff8436b1a786943a86"
SRC_URI[sha256sum] = "fbe82af9b94ccced752527c8de07fa20267f9634b48674ba478a0bb4000a0b1e"

DEPENDS += "${PYTHON_PN}-pip-native"

RDEPENDS_${PN} += " \
    python3-docker-pycreds \
    python3-requests \
    python3-websocket-client \
"
