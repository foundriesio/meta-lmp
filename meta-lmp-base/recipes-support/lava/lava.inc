HOMEPAGE = "https://gitlab.com/lava/lava"
SECTION = "test"
LICENSE = "GPL-2.0-or-later"
LIC_FILES_CHKSUM = "file://usr/share/doc/${BPN}/copyright;md5=f50c7ec77b69a421f78bbaa59851f74c"

SRC_URI = "http://apt.lavasoftware.org/release/pool/main/l/lava/${BPN}_${_PV}%2b${_PR}%2bbullseye_all.deb;subdir=${BPN}"

_PV = "${@oe.utils.trim_version("${PV}", 2)}"
_PR = "${@d.getVar('PV').split('.')[-1]}"
_PVS = "${@d.getVar('_PV').replace('.0','.')}"
_BPN = "${@d.getVar('BPN').replace('-','_')}"

inherit allarch bin_package python3-dir

S = "${WORKDIR}/${BPN}"

do_install:append() {
    # fix python libdir
    mv ${D}${libdir}/python3 ${D}${libdir}/${PYTHON_DIR}
    # fix python site-packages
    mv ${D}${libdir}/${PYTHON_DIR}/dist-packages ${D}${PYTHON_SITEPACKAGES_DIR}
    # delete what is not relevant
    rm -r ${D}${PYTHON_SITEPACKAGES_DIR}/${_BPN}-${_PVS}.egg-info
    rm -r ${D}${datadir}/doc
}

RDEPENDS:${PN} += "python3-core"
