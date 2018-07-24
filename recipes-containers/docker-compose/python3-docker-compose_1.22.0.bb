SUMMARY = "Multi-container orchestration for Docker"
HOMEPAGE = "https://www.docker.com/"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=435b266b3899aa8a959f17d41c56def8"

inherit pypi setuptools3

SRC_URI[md5sum] = "2c6030d4f7267a583a16debfd493e4a7"
SRC_URI[sha256sum] = "915cdd0ea7aff349d27a8e0585124ac38695635201770a35612837b25e234677"

SRC_URI_append = " file://support-newer-version-of-requests.patch"

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
  ${PYTHON_PN}-pyyaml \
  ${PYTHON_PN}-requests \
  ${PYTHON_PN}-six \
  ${PYTHON_PN}-terminal \
  ${PYTHON_PN}-texttable \
  ${PYTHON_PN}-urllib3 \
  ${PYTHON_PN}-websocket-client \
  "
