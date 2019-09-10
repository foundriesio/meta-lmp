SUMMARY = "Python module that implements the SSH2 protocol"
HOMEPAGE = "https://github.com/paramiko/paramiko"
LICENSE = "LGPLv2.1"
LIC_FILES_CHKSUM = "file://LICENSE;md5=fd0120fc2e9f841c73ac707a30389af5"

inherit pypi setuptools3

SRC_URI[md5sum] = "416f097b48af7d77472ce24a22f8b435"
SRC_URI[sha256sum] = "c6de454b3be8d35100d95d62b8073e429ed35326d574649f173c0acf7d72b2eb"

RDEPENDS_${PN} += " \
    python3-bcrypt \
    python3-cryptography \
    python3-pyasn1 \
    python3-nacl \
"
