SUMMARY = "Aktualizr configuration snippet to enable Foundries.IO UEFI Capsule updates"
HOMEPAGE = "https://github.com/advancedtelematic/aktualizr"
SECTION = "base"
LICENSE = "MPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MPL-2.0;md5=815ca599c9df247a0c7f619bab123dad"

inherit allarch

SRC_URI = "file://sota-fioefi-env.toml"

S = "${WORKDIR}"

do_install() {
    install -m 0700 -d ${D}${libdir}/sota/conf.d
    install -m 0644 ${WORKDIR}/sota-fioefi-env.toml ${D}${libdir}/sota/conf.d/30-rollback.toml
}

FILES:${PN} = " \
    ${libdir}/sota/conf.d \
    ${libdir}/sota/conf.d/30-rollback.toml \
"
