SUMMARY = "PKCS#11 HSM/Token Emulator"
HOMEPAGE = "https://www.opendnssec.org/softhsm/"
LICENSE = "BSD-2-Clause & ISC"
LIC_FILES_CHKSUM = "file://LICENSE;md5=ef3f77a3507c3d91e75b9f2bdaee4210"
DEPENDS = "openssl"
PV = "2.6.1"

SRC_URI = "git://github.com/opendnssec/SoftHSMv2.git;branch=develop \
	   file://tmpfiles.conf \
"

SRCREV = "7f99bedae002f0dd04ceeb8d86d59fc4a68a69a0"

S = "${WORKDIR}/git"

inherit autotools pkgconfig

EXTRA_OECONF = "--enable-ecc --enable-eddsa --disable-gost --with-crypto-backend=openssl"

BBCLASSEXTEND = "native"

do_install_append() {
	if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
		install -D -m 0644 ${WORKDIR}/tmpfiles.conf ${D}${nonarch_libdir}/tmpfiles.d/softhsm.conf
	fi
}

FILES_${PN} += "${nonarch_libdir}/tmpfiles.d/softhsm.conf"
