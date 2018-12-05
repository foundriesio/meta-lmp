SUMMARY = "A Python library for the Docker Engine API."
HOMEPAGE = "https://github.com/docker/docker-py"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=34f3846f940453127309b920eeb89660"

inherit pypi setuptools3

SRC_URI[md5sum] = "9c3b5e04a23ee78ec55b6f0c2e45dbed"
SRC_URI[sha256sum] = "145c673f531df772a957bd1ebc49fc5a366bcd55efa0e64bbd029f5cc7a1fd8e"

DEPENDS += "${PYTHON_PN}-pip-native"

RDEPENDS_${PN} += " \
    python3-docker-pycreds \
    python3-requests \
    python3-websocket-client \
"
