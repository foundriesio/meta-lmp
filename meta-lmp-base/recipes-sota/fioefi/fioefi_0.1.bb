SUMMARY = "Foundries.IO UEFI Firmware Update control script"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

SRC_URI = "file://fioefi.sh.in"
RDEPENDS:${PN} = " lmp-boot-firmware"

S = "${WORKDIR}"
B = "${WORKDIR}/build"

do_compile() {
    # Check if the file wasn't created by soc-specific do_compile() prepend
    if [ ! -e ${B}/fioefi ]; then
        sed -e 's/@@INCLUDE_SOC_FUNCTIONS@@//g' ${S}/fioefi.sh.in > ${B}/fioefi
    fi
}

do_install () {
    install -d ${D}${bindir}
    install -m 0755 ${B}/fioefi ${D}${bindir}/fioefi
    ln -sf fioefi ${D}${bindir}/fioefi_printenv
    ln -sf fioefi ${D}${bindir}/fioefi_setenv
    ln -sf fioefi ${D}${bindir}/fioefi_delenv
}
