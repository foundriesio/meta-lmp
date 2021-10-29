DESCRIPTION = "Recipe to deploy a signed bitstream"
LICENSE = "MIT"
SECTION = "firmware"

# Proprietary by default, correct license depends on the bistream
LICENSE = "Proprietary"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Proprietary;md5=0557f9d92cf58f2ccdd50f62f8ac0b28"

SRC_URI = "file://bitstream-signed.bit.bin"

PROVIDES = "virtual/bitstream"
PACKAGE_ARCH = "${MACHINE_ARCH}"
INHIBIT_DEFAULT_DEPS = "1"

S = "${WORKDIR}"

inherit deploy

do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_install() {
    install -d ${D}${nonarch_base_libdir}/firmware/
    for bitstream in ${S}/*.bin; do
        install -m 644 ${bitstream} ${D}${nonarch_base_libdir}/firmware/
    done
}

do_deploy() {
    for bitstream in ${S}/*.bin; do
        install -m 644 ${bitstream} ${DEPLOYDIR}/
    done
}

addtask do_deploy after do_install

FILES_${PN} += "${nonarch_base_libdir}/firmware"
