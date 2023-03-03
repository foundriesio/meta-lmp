SUMMARY = "A PKCS#11 interface for TPM2 hardware"
DESCRIPTION = "PKCS #11 is a Public-Key Cryptography Standard that defines a standard method to access cryptographic services from tokens/ devices such as hardware security modules (HSM), smart cards, etc. In this project we intend to use a TPM2 device as the cryptographic token."
SECTION = "security/tpm"
LICENSE = "BSD-2-Clause"
LIC_FILES_CHKSUM = "file://LICENSE;md5=0fc19f620a102768d6dbd1e7166e78ab"

DEPENDS = "autoconf-archive pkgconfig sqlite3 openssl libtss2-dev tpm2-tools libyaml p11-kit python3-setuptools-native"

SRC_URI = "https://github.com/tpm2-software/${BPN}/releases/download/${PV}/${BPN}-${PV}.tar.gz \
           file://0001-lib-ecdh1-derive-simple-implementation-for-KDF-null.patch \
           file://0002-test-pkcs11-tool.sh-ECDH1-shared-secret-generation.patch \
           file://0003-test-pkcs11-tool.sh-replace-call-to-pkcs11-tool-for-.patch \
           file://0004-test-integration-validate-ECDH-1-with-EC-NIST-P256.patch \
           file://0005-Fix-failing-database-upgrade.patch \
           file://0006-db-add-test-for-building-lock-file-path.patch \
           file://0007-db-fix-PKCS11_SQL_LOCK-usage.patch \
           file://0008-configure-update-with-fapi-configure-option.patch \
           file://0009-test-use-default-not-base-in-openssl-provider.patch \
           "

SRC_URI[sha256sum] = "35bf06c30cfa76fc0eba2c5f503cf7dd0d34a66afb2d292fee896b90362f633b"

UPSTREAM_CHECK_URI = "https://github.com/tpm2-software/${BPN}/releases"

inherit autotools-brokensep pkgconfig python3native

PACKAGECONFIG ?= "fapi"
PACKAGECONFIG[fapi] = "--with-fapi=yes,--with-fapi=no,tpm2-tss"

EXTRA_OECONF += "--disable-ptool-checks"

do_compile:append() {
    cd ${S}/tools
    python3 setup.py build
}

do_install:append() {
    cd ${S}/tools
    export PYTHONPATH="${D}${PYTHON_SITEPACKAGES_DIR}"
    ${PYTHON_PN} setup.py install --root="${D}" --prefix="${prefix}" --install-lib="${PYTHON_SITEPACKAGES_DIR}" --optimize=1 --skip-build

    sed -i -e "s:${PYTHON}:${USRBINPATH}/env ${PYTHON_PN}:g" "${D}${bindir}"/tpm2_ptool
}

PACKAGES =+ "${PN}-tools"

FILES:${PN}-tools = "\
    ${bindir}/tpm2_ptool \
    ${libdir}/${PYTHON_DIR}/* \
    "

FILES:${PN} += "\
    ${libdir}/pkcs11/* \
    ${datadir}/p11-kit/* \
    "

INSANE_SKIP:${PN}   += "dev-so"

RDEPENDS:${PN} = "p11-kit tpm2-tools "
RDEPENDS:${PN}-tools = "${PYTHON_PN}-pyyaml ${PYTHON_PN}-cryptography ${PYTHON_PN}-pyasn1-modules"
