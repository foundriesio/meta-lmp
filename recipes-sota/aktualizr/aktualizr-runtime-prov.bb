SUMMARY = "Aktualizr configuration for runtime provisioning"
DESCRIPTION = "Configuration for runtime provisioning Aktualizr"
HOMEPAGE = "https://github.com/advancedtelematic/aktualizr"
SECTION = "base"
LICENSE = "MPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MPL-2.0;md5=815ca599c9df247a0c7f619bab123dad"

DEPENDS = "aktualizr-native"
RDEPENDS_${PN} = "aktualizr"

do_install() {
    install -d ${D}${libdir}/sota

    AKTUALIZR_PARAMETERS_CONFIGFILE=""
    echo "AKTUALIZR_CMDLINE_PARAMETERS=${AKTUALIZR_PARAMETERS_CONFIGFILE}" > ${D}${libdir}/sota/sota.env
}

FILES_${PN}_append = " ${libdir}/sota/sota.env"
