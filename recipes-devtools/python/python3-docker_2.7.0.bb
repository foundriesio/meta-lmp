SUMMARY = "A Python library for the Docker Engine API."
HOMEPAGE = "https://github.com/docker/docker-py"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=34f3846f940453127309b920eeb89660"

inherit pypi setuptools3

SRC_URI[md5sum] = "994e82eaa070c45797c82547f94fc0b6"
SRC_URI[sha256sum] = "144248308e8ea31c4863c6d74e1b55daf97cc190b61d0fe7b7313ab920d6a76c"

DEPENDS += "${PYTHON_PN}-pip-native"

RDEPENDS_${PN} += " \
        python3-docker-pycreds \
        python3-requests \
        python3-websocket-client \
"
