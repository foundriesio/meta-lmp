SUMMARY = "A Python library for the Docker Engine API."
HOMEPAGE = "https://github.com/docker/docker-py"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=34f3846f940453127309b920eeb89660"

inherit pypi setuptools3

SRC_URI[md5sum] = "b587dbf18e0731a25fd1b6439f65dab1"
SRC_URI[sha256sum] = "0d698c3dc4df66c988de5df21a62cdc3450de2fa8523772779e5e23799c41f43"

DEPENDS += "${PYTHON_PN}-pip-native"

RDEPENDS_${PN} += " \
        python3-docker-pycreds \
        python3-requests \
        python3-websocket-client \
"
