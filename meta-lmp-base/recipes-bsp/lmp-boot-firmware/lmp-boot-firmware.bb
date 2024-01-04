SUMMARY = "Linux microPlatform Boot Firmware Files"
DESCRIPTION = "Linux microPlatform boot firmware files for boot firmware OTA support"
HOMEPAGE = "https://github.com/foundriesio/meta-lmp"
SECTION = "firmware"

# Set default LICENSE to MIT, but it is expected for the user to replace based
# on the dependencies and everything it includes (which is SoC/machine specific)
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

inherit deploy

INHIBIT_DEFAULT_DEPS = "1"

PACKAGE_ARCH = "${MACHINE_ARCH}"

S = "${WORKDIR}"
LMP_BOOT_FIRMWARE_VERSION ?= "0"

# Can be replaced by the user (via bbappend), which will reflect into version.txt
PV = "${LMP_BOOT_FIRMWARE_VERSION}"

# To be customized per machine (referenced from DEPLOY_DIR_IMAGE)
LMP_BOOT_FIRMWARE_FILES ?= ""

FIRMWARE_DEPLOY_DIR = "${nonarch_base_libdir}/${@bb.utils.contains('OSTREE_DEPLOY_USR_OSTREE_BOOT', '1', 'ostree-boot', 'firmware', d)}"

do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_install() {
    if [ -n "${LMP_BOOT_FIRMWARE_FILES}" ]; then
        install -d ${D}${nonarch_base_libdir}/firmware/
        install -d ${D}${nonarch_base_libdir}/ostree-boot/

        # Unfortunately we can't extract the files required via sysroot/install
        # as the signing process happens at the deployed files, so refer to the
        # firmware files from the deploy folder when generating this package,
        # unless it gets provided via SRC_URI (e.g. signed firmware such as SPL)
        for file in ${LMP_BOOT_FIRMWARE_FILES}; do
            if [ -f ${S}/${file} ]; then
                f=${S}/${file}
            elif [ -f ${DEPLOY_DIR_IMAGE}/${file} ]; then
                f=${DEPLOY_DIR_IMAGE}/${file}
            else
                bbfatal "File "${file}" not found in "${S}" and "${DEPLOY_DIR_IMAGE}""
            fi
            install -m 644 ${f} ${D}${FIRMWARE_DEPLOY_DIR}
        done

        # Generate version.txt based on PV and/or md5sum of every firmware file
        if [ "${PV}" != "0" ]; then
            version="${PV}"
        else
            for file in `ls ${D}${FIRMWARE_DEPLOY_DIR}/`; do
                version="${version}-`md5sum ${D}${FIRMWARE_DEPLOY_DIR}/${file} | cut -d' ' -f1`"
            done

            # limit the length of version
            version="`echo ${version} | md5sum | cut -d' ' -f1`"
        fi
        echo "bootfirmware_version=${version#-}" > ${B}/version.txt

        # Make version.txt available on both dirs for compatibility with aktualizr-lite
        install -m 644 ${B}/version.txt ${D}${nonarch_base_libdir}/firmware/
        if [ "${OSTREE_DEPLOY_USR_OSTREE_BOOT}" != "0" ]; then
            install -m 644 ${B}/version.txt ${D}${nonarch_base_libdir}/ostree-boot/
        fi
    fi
}
do_install[depends] = "${@bb.utils.contains('WKS_FILE_DEPENDS', 'virtual/bootloader', 'virtual/bootloader:do_deploy', '', d)}"
do_install[depends] += "${@bb.utils.contains('WKS_FILE_DEPENDS', 'virtual/trusted-firmware-a', 'virtual/trusted-firmware-a:do_deploy', '', d)}"
do_install[depends] += "${@bb.utils.contains('WKS_FILE_DEPENDS', 'imx-boot', 'imx-boot:do_deploy', '', d)}"

do_deploy() {
    if [ -n "${LMP_BOOT_FIRMWARE_FILES}" ]; then
        cp --no-preserve=ownership --recursive ${D}${FIRMWARE_DEPLOY_DIR} ${DEPLOYDIR}/lmp-boot-firmware
    fi
}
addtask deploy after do_install

ALLOW_EMPTY:${PN} = "1"
FILES:${PN} = "\
	${nonarch_base_libdir}/firmware \
	${nonarch_base_libdir}/ostree-boot \
"
