SUMMARY = "MFGTOOL Support Files and Binaries"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit deploy

# Use standard mfgtool initramfs
INITRAMFS_IMAGE = "fsl-image-mfgtool-initramfs"
DEPENDS = "${INITRAMFS_IMAGE}"

UUU_RELEASE = "1.3.102"

SRC_URI = "https://github.com/foundriesio/mfgtools/releases/download/uuu_fio_${UUU_RELEASE}/uuu;name=Linux \
    https://github.com/foundriesio/mfgtools/releases/download/uuu_fio_${UUU_RELEASE}/uuu.exe;name=Windows \
    https://github.com/foundriesio/mfgtools/releases/download/uuu_fio_${UUU_RELEASE}/uuu-static.exe;name=Windows-static \
    file://bootloader.uuu.in \
    file://full_image.uuu.in \
"

SRC_URI[Linux.md5sum] = "49388339c48960f16d3dbb816f861496"
SRC_URI[Linux.sha256sum] = "0d69734557b64f7eb4049dda9e2b558666352a85062e3753cc67a9694f40cc6e"
SRC_URI[Windows.md5sum] = "c6c52b4a0d9602a7028f60181345e311"
SRC_URI[Windows.sha256sum] = "7f4bf859eecb871b569b920ff03010673f3c88dfa64cf75cab2f680271db6c48"
SRC_URI[Windows-static.md5sum] = "5191241f11a9ec9674e1aa27ef43ab4b"
SRC_URI[Windows-static.sha256sum] = "7ba8ebe62c5925b01dcdfdf6eaf34c065a5328aad08cd0638c1dcc1b4ac36cee"

S = "${WORKDIR}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

do_compile() {
    sed -e 's/@@MACHINE@@/${MACHINE}/' ${S}/bootloader.uuu.in > bootloader.uuu
    sed -e 's/@@MACHINE@@/${MACHINE}/' ${S}/full_image.uuu.in > full_image.uuu
}

# Board specific SPL/U-Boot should be deployed via bbappend
do_deploy() {
    install -d ${DEPLOYDIR}/${PN}
    install -m 0755 ${WORKDIR}/uuu ${DEPLOYDIR}/${PN}
    install -m 0644 ${WORKDIR}/uuu.exe ${DEPLOYDIR}/${PN}
    install -m 0644 ${WORKDIR}/uuu-static.exe ${DEPLOYDIR}/${PN}
    install -m 0644 ${WORKDIR}/bootloader.uuu ${DEPLOYDIR}/${PN}
    install -m 0644 ${WORKDIR}/full_image.uuu ${DEPLOYDIR}/${PN}

    tar -czf ${DEPLOYDIR}/${PN}.tar.gz -C ${DEPLOYDIR} ${PN}
}

# Make sure the signed fitImage and u-boot are deployed
do_deploy[depends] += "virtual/bootloader:do_deploy"
do_deploy[depends] += "virtual/kernel:do_deploy"

addtask deploy after do_install before do_build
