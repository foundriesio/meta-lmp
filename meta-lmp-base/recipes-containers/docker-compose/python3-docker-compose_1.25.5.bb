SUMMARY = "Multi-container orchestration for Docker"
HOMEPAGE = "https://www.docker.com/"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=435b266b3899aa8a959f17d41c56def8"

inherit pypi setuptools3

SRC_URI[md5sum] = "a6f296957148e4c61b28fb324c27c966"
SRC_URI[sha256sum] = "7a2eb6d8173fdf408e505e6f7d497ac0b777388719542be9e49a0efd477a50c6"

SRC_URI += "file://0001-setup.py-remove-maximum-version-requirements.patch \
            file://0001-setup.py-import-fastentrypoints.patch \
           "

DEPENDS += "${PYTHON_PN}-fastentrypoints-native"

RDEPENDS_${PN} = "\
    ${PYTHON_PN}-cached-property \
    ${PYTHON_PN}-certifi \
    ${PYTHON_PN}-chardet \
    ${PYTHON_PN}-colorama \
    ${PYTHON_PN}-docker \
    ${PYTHON_PN}-docker-pycreds \
    ${PYTHON_PN}-dockerpty \
    ${PYTHON_PN}-docopt \
    ${PYTHON_PN}-fcntl \
    ${PYTHON_PN}-idna \
    ${PYTHON_PN}-jsonschema \
    ${PYTHON_PN}-misc \
    ${PYTHON_PN}-paramiko \
    ${PYTHON_PN}-pyyaml \
    ${PYTHON_PN}-requests \
    ${PYTHON_PN}-six \
    ${PYTHON_PN}-terminal \
    ${PYTHON_PN}-texttable \
    ${PYTHON_PN}-urllib3 \
    ${PYTHON_PN}-websocket-client \
"
