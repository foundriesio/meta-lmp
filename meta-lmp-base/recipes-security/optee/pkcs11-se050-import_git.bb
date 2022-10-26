SUMMARY = "Tool to import NXP SE050 Secure Objects into PKCS11 / OP-TEE"
HOMEPAGE = "https://github.com/foundriesio/pkcs11-cert-import-apdu"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/BSD-3-Clause;md5=550794465ba0ec5312d6919e203a55f9"

DEPENDS = "optee-os-tadevkit optee-client openssl"

SRC_URI = "git://github.com/foundriesio/pkcs11-cert-import-apdu.git;protocol=https;branch=main"
SRCREV = "2ecc34de7b58559df238fff964065103e2712749"

S = "${WORKDIR}/git"

TEEC_EXPORT = "${STAGING_DIR_HOST}${prefix}"
EXTRA_OEMAKE = "TEEC_EXPORT=${TEEC_EXPORT}"

do_install() {
	install -d ${D}${bindir}
	install -m 0755 ${S}/pkcs11-se050-import ${D}${bindir}
}

RDEPENDS:${PN} = "opensc"
