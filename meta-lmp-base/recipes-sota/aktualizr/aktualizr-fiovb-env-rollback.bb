SUMMARY = "Aktualizr configuration snippet to enable Foundries.IO verified boot bootcount function"
HOMEPAGE = "https://github.com/advancedtelematic/aktualizr"
SECTION = "base"
LICENSE = "MPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MPL-2.0;md5=815ca599c9df247a0c7f619bab123dad"

inherit allarch

SRC_URI = "file://sota-fiovb-env.toml"

PV = "1.0"

S = "${WORKDIR}"

do_install() {
    install -m 0700 -d ${D}${libdir}/sota/conf.d
    install -m 0644 ${WORKDIR}/sota-fiovb-env.toml ${D}${libdir}/sota/conf.d/30-rollback.toml
}

FILES_${PN} = " \
    ${libdir}/sota/conf.d \
    ${libdir}/sota/conf.d/30-rollback.toml \
"
