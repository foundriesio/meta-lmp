SUMMARY = "Tool to import NXP SE050 Secure Objects into PKCS11 / OP-TEE"
HOMEPAGE = "https://github.com/foundriesio/optee-se050-pkcs11-import"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/BSD-3-Clause;md5=550794465ba0ec5312d6919e203a55f9"

DEPENDS = "virtual/optee-os optee-client"

SRC_URI = "git://github.com/foundriesio/optee-se050-pkcs11-import.git;branch=main"
SRCREV = "575c71c4c5cb7b7273232e55b776f6ce984b4e67"

S = "${WORKDIR}/git"

TEEC_EXPORT = "${STAGING_DIR_HOST}${prefix}"
EXTRA_OEMAKE = "TEEC_EXPORT=${TEEC_EXPORT}"

do_install() {
	install -d ${D}${bindir}
	install -m 0755 ${S}/pkcs11-se050-import ${D}${bindir}
}

RDEPENDS_${PN} = "opensc"
