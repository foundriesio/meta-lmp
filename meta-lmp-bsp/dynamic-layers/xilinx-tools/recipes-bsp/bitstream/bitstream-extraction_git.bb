DESCRIPTION = "Recipe to extract bitstream"

LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

DEPENDS += "virtual/hdf"

PROVIDES = "virtual/bitstream"

PACKAGE_ARCH ?= "${MACHINE_ARCH}"

inherit xsctbit deploy

XSCTH_MISC = "-hwpname ${XSCTH_PROJ}_hwproj -hdf_type ${HDF_EXT}"

do_compile[noexec] = "1"

SYSROOT_DIRS += "${nonarch_base_libdir}/firmware"

do_install() {

    if [ -e ${XSCTH_WS}/${XSCTH_PROJ}_hwproj/*.bit ]; then
        install -d ${D}/${nonarch_base_libdir}/firmware/
        ln -s /var/lib/firmware/bitstream ${D}/${nonarch_base_libdir}/firmware/bitstream
        install -Dm 0644 ${XSCTH_WS}/${XSCTH_PROJ}_hwproj/*.bit ${D}/${nonarch_base_libdir}/firmware/
    fi
}

do_deploy() {
}
addtask do_deploy after do_install

FILES_${PN} += "${nonarch_base_libdir}/firmware/bitstream ${nonarch_base_libdir}/firmware/*.bit"
