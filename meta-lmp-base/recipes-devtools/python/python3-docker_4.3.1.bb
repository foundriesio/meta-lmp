SUMMARY = "A Python library for the Docker Engine API."
HOMEPAGE = "https://github.com/docker/docker-py"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=34f3846f940453127309b920eeb89660"

SRC_URI[md5sum] = "ce28bd52fe2e33a26394693f01199e6c"
SRC_URI[sha256sum] = "bad94b8dd001a8a4af19ce4becc17f41b09f228173ffe6a4e0355389eef142f2"

DEPENDS += "${PYTHON_PN}-pip-native"

RDEPENDS_${PN} += " \
        ${PYTHON_PN}-misc \
        ${PYTHON_PN}-six \
        ${PYTHON_PN}-docker-pycreds \
        ${PYTHON_PN}-requests \
        ${PYTHON_PN}-websocket-client \
"

inherit pypi setuptools3
