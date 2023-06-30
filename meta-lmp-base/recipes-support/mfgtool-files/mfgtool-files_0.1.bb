SUMMARY = "MFGTOOL Support Files and Binaries"
LICENSE = "BSD-3-Clause & LGPL-2.1-or-later"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/BSD-3-Clause;md5=550794465ba0ec5312d6919e203a55f9 \
                    file://${COMMON_LICENSE_DIR}/LGPL-2.1-or-later;md5=2a4f4fd2128ea2f65047ee63fbca9f68"

inherit deploy nopackages

# Use standard mfgtool initramfs
INITRAMFS_IMAGE = "fsl-image-mfgtool-initramfs"
DEPENDS = "${INITRAMFS_IMAGE}"

UUU_RELEASE = "1.5.109"
MFGTOOL_FLASH_IMAGE ?= "lmp-base-console-image"

SRC_URI = " \
    https://github.com/NXPmicro/mfgtools/releases/download/uuu_${UUU_RELEASE}/uuu;downloadfilename=uuu-${UUU_RELEASE};name=Linux \
    https://github.com/NXPmicro/mfgtools/releases/download/uuu_${UUU_RELEASE}/uuu_mac;downloadfilename=uuu-${UUU_RELEASE}_mac;name=Mac \
    https://github.com/NXPmicro/mfgtools/releases/download/uuu_${UUU_RELEASE}/uuu.exe;downloadfilename=uuu-${UUU_RELEASE}.exe;name=Windows \
    file://bootloader.uuu.in \
    file://full_image.uuu.in \
"

SRC_URI[Linux.sha256sum] = "d5568f967a686dcef4f60932baba2dc8393b79e43dab5c1437226b2a34658a40"
SRC_URI[Mac.sha256sum] = "2e37d04e7e4435e25dbe0f9463efe672324e1718b0a272b2d6627b90e13cb4fa"
SRC_URI[Windows.sha256sum] = "ae5dd2b1a6575d1a2416a51ab849009bcaf230d803692c46ade95266b6dcc08e"

S = "${WORKDIR}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

do_compile() {
    sed -e 's/@@MACHINE@@/${MACHINE}/' ${S}/bootloader.uuu.in > bootloader.uuu
    sed -e 's/@@MACHINE@@/${MACHINE}/' \
        -e 's/@@MFGTOOL_FLASH_IMAGE@@/${MFGTOOL_FLASH_IMAGE}/' \
        ${S}/full_image.uuu.in > full_image.uuu
}

# Board specific SPL/U-Boot should be deployed via bbappend
do_deploy() {
    install -d ${DEPLOYDIR}/${PN}
    install -m 0755 ${WORKDIR}/uuu-${UUU_RELEASE} ${DEPLOYDIR}/${PN}/uuu
    install -m 0755 ${WORKDIR}/uuu-${UUU_RELEASE}_mac ${DEPLOYDIR}/${PN}/uuu_mac
    install -m 0644 ${WORKDIR}/uuu-${UUU_RELEASE}.exe ${DEPLOYDIR}/${PN}/uuu.exe
    install -m 0644 ${WORKDIR}/bootloader.uuu ${DEPLOYDIR}/${PN}
    install -m 0644 ${WORKDIR}/full_image.uuu ${DEPLOYDIR}/${PN}

    tar -czf ${DEPLOYDIR}/${PN}-${MACHINE}.tar.gz \
	    --transform "s,^mfgtool-files,mfgtool-files-${MACHINE}," \
	    -C ${DEPLOYDIR} ${PN}

    ln -s ${PN}-${MACHINE}.tar.gz ${DEPLOYDIR}/${PN}.tar.gz
}

# Make sure the signed fitImage and u-boot are deployed
do_deploy[depends] += "virtual/bootloader:do_deploy"
do_deploy[depends] += "virtual/kernel:do_deploy"

addtask deploy after do_compile before do_build

python() {
    # we need to set the DEPENDS as well to produce valid SPDX documents
    fix_deployed_depends('do_deploy', d)
}
