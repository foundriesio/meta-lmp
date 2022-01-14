DESCRIPTION = "Recipe to extract bitstream"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

DEPENDS += "virtual/hdf bootgen-native"

PROVIDES = "virtual/bitstream"

PACKAGE_ARCH ?= "${MACHINE_ARCH}"

inherit xsctbit deploy

XSCTH_MISC = "-hwpname ${XSCTH_PROJ}_hwproj -hdf_type ${HDF_EXT}"

SYSROOT_DIRS += "${nonarch_base_libdir}/firmware"

generate_bin() {
    BITPATH=${XSCTH_WS}/${XSCTH_PROJ}_hwproj/*.bit
    bitname=`basename -s .bit ${BITPATH}`
    printf "all:\n{\n\t`ls ${BITPATH}`\n}" > ${bitname}.bif
    bootgen -image ${bitname}.bif -arch ${SOC_FAMILY} -o ${bitname}.bit.bin -w on \
        ${@bb.utils.contains('SOC_FAMILY','zynqmp','','-process_bitstream bin',d)}

    if [ ! -e "${bitname}.bit.bin" ]; then
        bbfatal "bootgen failed. Enable -log debug with bootgen and check logs"
    fi
}

do_compile() {
    if [ -e ${XSCTH_WS}/${XSCTH_PROJ}_hwproj/*.bit ]; then
        generate_bin
    fi
}

do_install() {
    if [ -e ${XSCTH_WS}/${XSCTH_PROJ}_hwproj/*.bit ]; then
        install -d ${D}/${nonarch_base_libdir}/firmware/
        ln -s /var/lib/firmware/bitstream ${D}/${nonarch_base_libdir}/firmware/bitstream
        install -Dm 0644 ${XSCTH_WS}/*.bit.bin ${D}/${nonarch_base_libdir}/firmware/bitstream.bit.bin
        install -Dm 0644 ${XSCTH_WS}/${XSCTH_PROJ}_hwproj/*.bit ${D}/${nonarch_base_libdir}/firmware/bitstream.bit
    fi
}

do_deploy() {
    if [ -e ${XSCTH_WS}/${XSCTH_PROJ}_hwproj/*.bit ]; then
        install -Dm 0644 ${XSCTH_WS}/*.bit.bin ${DEPLOYDIR}/bitstream-${MACHINE}.bit.bin
        install -Dm 0644 ${XSCTH_WS}/${XSCTH_PROJ}_hwproj/*.bit ${DEPLOYDIR}/bitstream-${MACHINE}.bit
        ln -sf bitstream-${MACHINE}.bit.bin ${DEPLOYDIR}/bitstream.bit.bin
        ln -sf bitstream-${MACHINE}.bit ${DEPLOYDIR}/bitstream.bit
    fi
}

addtask do_deploy after do_install

FILES_${PN} += "${nonarch_base_libdir}/firmware"
