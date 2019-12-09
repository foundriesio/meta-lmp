SUMMARY = "A Python library for the Docker Engine API."
HOMEPAGE = "https://github.com/docker/docker-py"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=34f3846f940453127309b920eeb89660"

inherit pypi setuptools3

SRC_URI[md5sum] = "a4e1f25103b46853cfcbc4c355cf74fa"
SRC_URI[sha256sum] = "a062a9f82dff025f79c2097c46f49f143f8898274db7e66041f78cafee66b962"

SRC_URI += " \
    file://0001-config-Include-usr-lib-docker-in-search-path.patch \
"

DEPENDS += "${PYTHON_PN}-pip-native"

RDEPENDS_${PN} += " \
    python3-docker-pycreds \
    python3-requests \
    python3-websocket-client \
"
