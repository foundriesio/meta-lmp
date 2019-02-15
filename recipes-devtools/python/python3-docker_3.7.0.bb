SUMMARY = "A Python library for the Docker Engine API."
HOMEPAGE = "https://github.com/docker/docker-py"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=34f3846f940453127309b920eeb89660"

inherit pypi setuptools3

SRC_URI[md5sum] = "0ae0b2e02c61b1c690dd3e581e48a2aa"
SRC_URI[sha256sum] = "2840ffb9dc3ef6d00876bde476690278ab13fa1f8ba9127ef855ac33d00c3152"

DEPENDS += "${PYTHON_PN}-pip-native"

RDEPENDS_${PN} += " \
    python3-docker-pycreds \
    python3-requests \
    python3-websocket-client \
"
