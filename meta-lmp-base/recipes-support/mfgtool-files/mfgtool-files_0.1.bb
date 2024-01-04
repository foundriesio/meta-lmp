SUMMARY = "MFGTOOL Support Files and Binaries"
LICENSE = "BSD-3-Clause & LGPL-2.1-or-later"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/BSD-3-Clause;md5=550794465ba0ec5312d6919e203a55f9 \
                    file://${COMMON_LICENSE_DIR}/LGPL-2.1-or-later;md5=2a4f4fd2128ea2f65047ee63fbca9f68"

inherit deploy nopackages

# Use standard mfgtool initramfs
INITRAMFS_IMAGE = "fsl-image-mfgtool-initramfs"
DEPENDS = "${INITRAMFS_IMAGE}"

UUU_RELEASE = "1.5.141"
MFGTOOL_FLASH_IMAGE ?= "lmp-base-console-image"

SRC_URI = " \
    https://github.com/NXPmicro/mfgtools/releases/download/uuu_${UUU_RELEASE}/uuu;downloadfilename=uuu-${UUU_RELEASE};name=Linux \
    https://github.com/NXPmicro/mfgtools/releases/download/uuu_${UUU_RELEASE}/uuu_mac;downloadfilename=uuu-${UUU_RELEASE}_mac;name=Mac \
    https://github.com/NXPmicro/mfgtools/releases/download/uuu_${UUU_RELEASE}/uuu.exe;downloadfilename=uuu-${UUU_RELEASE}.exe;name=Windows \
    file://bootloader.uuu.in \
    file://full_image.uuu.in \
"

SRC_URI[Linux.sha256sum] = "561012195adcea9ea92e81afc17f85a1a36af234aeadd0cf7688cedd60153578"
SRC_URI[Mac.sha256sum] = "d3d8e7c998a553648d3c75307b1a8d83415c6b2e6bb99591e877f10f64b4bba3"
SRC_URI[Windows.sha256sum] = "342be5d2f1d934e7c808c9835b0440063a86f783160017372c4ce5b0adae3815"

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
