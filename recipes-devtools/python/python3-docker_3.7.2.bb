SUMMARY = "A Python library for the Docker Engine API."
HOMEPAGE = "https://github.com/docker/docker-py"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=34f3846f940453127309b920eeb89660"

inherit pypi setuptools3

SRC_URI[md5sum] = "e367b2270d7eea2eccceb022e4929cde"
SRC_URI[sha256sum] = "c456ded5420af5860441219ff8e51cdec531d65f4a9e948ccd4133e063b72f50"

DEPENDS += "${PYTHON_PN}-pip-native"

RDEPENDS_${PN} += " \
    python3-docker-pycreds \
    python3-requests \
    python3-websocket-client \
"
