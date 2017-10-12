SUMMARY = "Python ASN.1 library with a focus on performance and a pythonic API"
DESCRIPTION = "Fast ASN.1 parser and serializer with definitions for private \
keys, public keys, certificates, CRL, OCSP, CMS, PKCS#3, PKCS#7, PKCS#8, \
PKCS#12, PKCS#5, X.509 and TSP"
HOMEPAGE = "https://github.com/wbond/asn1crypto"
SECTION = "devel/python"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://LICENSE;md5=52010cd3c7d7bd965b55721ef4d93ec2"

SRC_URI[md5sum] = "97d54665c397b72b165768398dfdd876"
SRC_URI[sha256sum] = "0874981329cfebb366d6584c3d16e913f2a0eb026c9463efcc4aaf42a9d94d70"

inherit pypi setuptools3
