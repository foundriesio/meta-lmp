SUMMARY = "Aktualizr configuration snippet to make sure pkcs#11 token is labeled properly"
HOMEPAGE = "https://github.com/advancedtelematic/aktualizr"
SECTION = "base"
LICENSE = "MPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MPL-2.0;md5=815ca599c9df247a0c7f619bab123dad"

inherit allarch

SRC_URI = "file://pkcs11-label.toml"

INHIBIT_DEFAULT_DEPS = "1"

PV = "1.0"

S = "${WORKDIR}"

do_install() {
    install -m 0700 -d ${D}${libdir}/sota/conf.d
    install -m 0644 ${WORKDIR}/pkcs11-label.toml ${D}${libdir}/sota/conf.d/46-pkcs11-label.toml
}

FILES:${PN} = " \
    ${libdir}/sota/conf.d/46-pkcs11-label.toml \
"
