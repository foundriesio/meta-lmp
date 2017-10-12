SUMMARY = "Python library for the Docker Engine API"
DESCRIPTION = "A Python library for the Docker Engine API. It lets you do \
anything the docker command does, but from within Python apps – run \
containers, manage containers, manage Swarms, etc."
HOMEPAGE = "https://github.com/docker/docker-py"
SECTION = "devel/python"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=34f3846f940453127309b920eeb89660"

SRC_URI[md5sum] = "7d917152976df075e6e90ee853df641f"
SRC_URI[sha256sum] = "b876e6909d8d2360e0540364c3a952a62847137f4674f2439320ede16d6db880"

PYPI_PACKAGE = "docker"
PYPI_PACKAGE_EXT = "tar.gz"

SRCNAME = "docker-py"
S = "${WORKDIR}/${SRCNAME}-${PV}"

inherit pypi setuptools3

DEPENDS += "python3-pip-native"

RDEPENDS_${PN} += "\
	python3-appdirs \
	python3-asn1crypto \
	python3-cffi \
	python3-cryptography \
	python3-docker-pycreds \
	python3-idna \
	python3-pycparser \
	python3-pyopenssl \
	python3-pyparsing \
	python3-requests \
	python3-six \
	python3-websocket-client \
"
