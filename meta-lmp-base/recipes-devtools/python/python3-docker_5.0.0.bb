SUMMARY = "A Python library for the Docker Engine API."
HOMEPAGE = "https://github.com/docker/docker-py"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=34f3846f940453127309b920eeb89660"

SRC_URI[md5sum] = "9cc5156a2ff6458a8f52114b9bbc0d7e"
SRC_URI[sha256sum] = "3e8bc47534e0ca9331d72c32f2881bb13b93ded0bcdeab3c833fb7cf61c0a9a5"

DEPENDS += "${PYTHON_PN}-pip-native"

RDEPENDS:${PN} += " \
        ${PYTHON_PN}-misc \
        ${PYTHON_PN}-six \
        ${PYTHON_PN}-docker-pycreds \
        ${PYTHON_PN}-requests \
        ${PYTHON_PN}-websocket-client \
"

inherit pypi setuptools3
