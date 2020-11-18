SUMMARY = "MFGTOOL Support Files and Binaries"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit deploy nopackages

# Use standard mfgtool initramfs
INITRAMFS_IMAGE = "fsl-image-mfgtool-initramfs"
DEPENDS = "${INITRAMFS_IMAGE}"

UUU_RELEASE = "1.4.43"
MFGTOOL_FLASH_IMAGE ?= "lmp-base-console-image"

SRC_URI = " \
    https://github.com/NXPmicro/mfgtools/releases/download/uuu_${UUU_RELEASE}/uuu;name=Linux \
    https://github.com/NXPmicro/mfgtools/releases/download/uuu_${UUU_RELEASE}/uuu.exe;name=Windows \
    file://bootloader.uuu.in \
    file://full_image.uuu.in \
"

SRC_URI[Linux.md5sum] = "e402adfbe3b142388fcd196ae5e0a74d"
SRC_URI[Linux.sha256sum] = "c09616f43e096683a5c4ad12a6e5684ac15a0f745758cd98a0a73d63faf071c7"
SRC_URI[Windows.md5sum] = "c2d7ca8e5367ce5d5ef8a54bf76449f3"
SRC_URI[Windows.sha256sum] = "958e894920a69d3fac60e09c602d4292b32f5eda5a50c1a1fa9a235bea18da51"

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
    install -m 0755 ${WORKDIR}/uuu ${DEPLOYDIR}/${PN}
    install -m 0644 ${WORKDIR}/uuu.exe ${DEPLOYDIR}/${PN}
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
