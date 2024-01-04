SUMMARY = "MFGTOOL Support Files and Binaries"
LICENSE = "BSD-3-Clause & LGPLv2.1+"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/BSD-3-Clause;md5=550794465ba0ec5312d6919e203a55f9 \
                    file://${COMMON_LICENSE_DIR}/LGPL-2.1-or-later;md5=2a4f4fd2128ea2f65047ee63fbca9f68"

inherit deploy nopackages

# Use installer initramfs
INITRAMFS_IMAGE ?= "initramfs-ostree-lmp-recovery"
DEPENDS = "${INITRAMFS_IMAGE}"

S = "${WORKDIR}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

SRC_URI = " \
    file://provision.sh.in \
"

do_compile() {
    sed -e 's:@@MACHINE@@:${MACHINE}:' \
        -e 's:@@BOARD_NAME@@:${LMP_FLASHLAYOUT_BOARD_NAME}:' \
        -e 's:@@FLASHLAYOUT_USB@@:${LMP_MFGTOOL_FLASHLAYOUT}:' \
        ${WORKDIR}/provision.sh.in > ${WORKDIR}/provision.sh
}

do_deploy() {
    install -d ${DEPLOYDIR}/${PN}
    install -m 0755 ${WORKDIR}/provision.sh ${DEPLOYDIR}/${PN}
}

addtask deploy after do_compile before do_build
