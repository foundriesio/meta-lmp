SUMMARY = "MFGTOOL Support Files and Binaries"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/BSD-3-Clause;md5=550794465ba0ec5312d6919e203a55f9 \
                    file://${COMMON_LICENSE_DIR}/LGPL-2.1-or-later;md5=2a4f4fd2128ea2f65047ee63fbca9f68"

inherit deploy nopackages

S = "${WORKDIR}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

SRC_URI = " \
    file://flash.sh.in \
"

do_compile() {
    sed -e 's/@@MACHINE@@/${MACHINE}/' \
        ${WORKDIR}/flash.sh.in > ${WORKDIR}/flash.sh
}

do_deploy() {
    install -d ${DEPLOYDIR}/${PN}
    install -m 0755 ${WORKDIR}/flash.sh ${DEPLOYDIR}/${PN}
    install -m 0644 ${DEPLOY_DIR_IMAGE}/tiboot3*.bin ${DEPLOYDIR}/${PN}/
    install -m 0644 ${DEPLOY_DIR_IMAGE}/tispl*.bin ${DEPLOYDIR}/${PN}/
    install -m 0644 ${DEPLOY_DIR_IMAGE}/u-boot*.img ${DEPLOYDIR}/${PN}/

    tar -czf ${DEPLOYDIR}/${PN}-${MACHINE}.tar.gz \
            --transform "s,^${PN},mfgtool-files-${MACHINE}," \
            -C ${DEPLOYDIR} ${PN}

    ln -s ${PN}-${MACHINE}.tar.gz ${DEPLOYDIR}/${PN}.tar.gz
}

# Make sure the fitImage and u-boot are deployed
do_deploy[depends] += "virtual/bootloader:do_deploy"

addtask deploy after do_compile before do_build
