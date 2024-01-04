SUMMARY = "MFGTOOL Support Files and Binaries"
LICENSE = "BSD-3-Clause & LGPL-2.1-or-later"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/BSD-3-Clause;md5=550794465ba0ec5312d6919e203a55f9 \
                    file://${COMMON_LICENSE_DIR}/LGPL-2.1-or-later;md5=2a4f4fd2128ea2f65047ee63fbca9f68"

inherit deploy nopackages

# Use standard mfgtool initramfs
INITRAMFS_IMAGE = "fsl-image-mfgtool-initramfs"
DEPENDS = "${INITRAMFS_IMAGE}"

UUU_RELEASE = "1.5.179"
MFGTOOL_FLASH_IMAGE ?= "lmp-base-console-image"

SRC_URI = " \
    https://github.com/NXPmicro/mfgtools/releases/download/uuu_${UUU_RELEASE}/uuu;downloadfilename=uuu-${UUU_RELEASE};name=Linux \
    https://github.com/NXPmicro/mfgtools/releases/download/uuu_${UUU_RELEASE}/uuu_mac_arm;downloadfilename=uuu-${UUU_RELEASE}_mac_arm;name=Mac_arm \
    https://github.com/NXPmicro/mfgtools/releases/download/uuu_${UUU_RELEASE}/uuu_mac_x86;downloadfilename=uuu-${UUU_RELEASE}_mac_x86;name=Mac_x86 \
    https://github.com/NXPmicro/mfgtools/releases/download/uuu_${UUU_RELEASE}/uuu.exe;downloadfilename=uuu-${UUU_RELEASE}.exe;name=Windows \
    file://bootloader.uuu.in \
    file://full_image.uuu.in \
"

SRC_URI[Linux.sha256sum] = "2be8c39b3af0b20c0c9604035ea49965d664777fff6da60572ee61d8dd226319"
SRC_URI[Mac_arm.sha256sum] = "f7722d0b12c273ee27279045dcb877cfbe59f6fd04513f2ed1f9f4fdecc649ba"
SRC_URI[Mac_x86.sha256sum] = "1558e23be37ce35cce556f480e296db3f68e21d40f17808beb7d25c3049f2953"
SRC_URI[Windows.sha256sum] = "e2c54198437b2c3235b35eabf886ec9540105c855a23c044083912cd91af4861"

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
    install -m 0755 ${WORKDIR}/uuu-${UUU_RELEASE}_mac_arm ${DEPLOYDIR}/${PN}/uuu_mac_arm
    install -m 0755 ${WORKDIR}/uuu-${UUU_RELEASE}_mac_x86 ${DEPLOYDIR}/${PN}/uuu_mac_x86
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
