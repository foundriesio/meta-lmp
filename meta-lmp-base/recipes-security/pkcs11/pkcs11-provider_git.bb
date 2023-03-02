HOMEPAGE = "https://github.com/latchset/pkcs11-provider"
SUMMARY =  "A pkcs#11 provider for OpenSSL 3.0+"
DESCRIPTION = "This is an Openssl 3.x provider to access Hardware or Software \
 Tokens using the PKCS#11 Cryptographic Token Interface"

LICENSE = "Apache-2.0 & OASIS"
LIC_FILES_CHKSUM = "file://COPYING;md5=b53b787444a60266932bd270d1cf2d45 \
                    file://LICENSES/LicenseRef-OASIS-IPR.txt;md5=d709b4c4f378c7ed5e113342135bfe57"

SRC_URI = "git://github.com/latchset/pkcs11-provider;protocol=https;branch=main \
           file://0001-configure.ac-fix-libsoftokn3-detection-when-cross-co.patch \
           "

PV = "0.1+git${SRCPV}"
SRCREV = "f6d320951b61697986f57123b396962287764195"

S = "${WORKDIR}/git"

DEPENDS = "autoconf-archive nss p11-kit openssl"

inherit pkgconfig autotools

FILES:${PN} += "${nonarch_base_libdir}/ossl-modules/pkcs11.so"
