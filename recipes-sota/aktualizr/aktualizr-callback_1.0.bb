SUMMARY = "Aktualizr configuration snippet to enable Foundries.IO callback function"
SECTION = "base"
LICENSE = "MPL-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MPL-2.0;md5=815ca599c9df247a0c7f619bab123dad"

inherit allarch

SRC_URI = "\
    file://90-handle-callback.toml \
    file://callback-handler \
"

do_install() {
    install -m 0700 -d ${D}${libdir}/sota/conf.d
    install -m 0755 -d ${D}${bindir}
    install -m 0644 ${WORKDIR}/90-handle-callback.toml ${D}${libdir}/sota/conf.d/90-handle-callback.toml
    install -m 0755 ${WORKDIR}/callback-handler ${D}${bindir}/callback-handler
}

FILES:${PN} = " \
    ${libdir}/sota/conf.d/90-handle-callback.toml \
    ${bindir}/callback-handler \
"

RDEPENDS:${PN} = "aktualizr-lite"
