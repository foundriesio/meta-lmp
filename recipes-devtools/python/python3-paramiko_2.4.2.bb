SUMMARY = "Python module that implements the SSH2 protocol"
HOMEPAGE = "https://github.com/paramiko/paramiko"
LICENSE = "LGPLv2.1"
LIC_FILES_CHKSUM = "file://LICENSE;md5=fd0120fc2e9f841c73ac707a30389af5"

inherit pypi setuptools3

SRC_URI[md5sum] = "a476ea106177fe22e797428d54811aed"
SRC_URI[sha256sum] = "a8975a7df3560c9f1e2b43dc54ebd40fd00a7017392ca5445ce7df409f900fcb"

RDEPENDS_${PN} += " \
    python3-bcrypt \
    python3-cryptography \
    python3-pyasn1 \
    python3-nacl \
"
