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

# Can be replaced by the user (via bbappend), which will reflect into version.txt
PV = "0"

# To be customized per machine (referenced from DEPLOY_DIR_IMAGE)
LMP_BOOT_FIRMWARE_FILES ?= ""

do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_install() {
    if [ -n "${LMP_BOOT_FIRMWARE_FILES}" ]; then
        install -d ${D}${nonarch_base_libdir}/firmware/

        # Unfortunately we can't extract the files required via sysroot/install
        # as the signing process happens at the deployed files, so refer to the
        # firmware files from the deploy folder when generating this package,
        # unless it gets provided via SRC_URI (e.g. signed firmware such as SPL)
        for file in ${LMP_BOOT_FIRMWARE_FILES}; do
            if [ -f ${S}/${file} ]; then
                install -m 644 ${S}/${file} ${D}${nonarch_base_libdir}/firmware/
            else
                install -m 644 ${DEPLOY_DIR_IMAGE}/${file} ${D}${nonarch_base_libdir}/firmware/
            fi
        done

        # Generate version.txt based on PV and/or md5sum of every firmware file
        if [ "${PV}" != "0" ]; then
            version="${PV}"
        else
            for file in `ls ${D}${nonarch_base_libdir}/firmware/`; do
                version="${version}-`md5sum ${D}${nonarch_base_libdir}/firmware/${file} | cut -d' ' -f1`"
            done
        fi
        echo "bootfirmware_version=${version#-}" > version.txt
        install -m 644 ${S}/version.txt ${D}${nonarch_base_libdir}/firmware/
    fi
}
do_install[depends] = "${@bb.utils.contains('WKS_FILE_DEPENDS', 'virtual/bootloader', 'virtual/bootloader:do_deploy', '', d)}"
do_install[depends] += "${@bb.utils.contains('WKS_FILE_DEPENDS', 'imx-boot', 'imx-boot:do_deploy', '', d)}"

do_deploy() {
    if [ -n "${LMP_BOOT_FIRMWARE_FILES}" ]; then
        install -d ${DEPLOYDIR}/lmp-boot-firmware
        for file in `ls ${D}${nonarch_base_libdir}/firmware/`; do
            install -m 644 ${D}${nonarch_base_libdir}/firmware/${file} ${DEPLOYDIR}/lmp-boot-firmware/
        done
    fi
}
addtask deploy after do_install

ALLOW_EMPTY_${PN} = "1"
FILES_${PN} = "${nonarch_base_libdir}/firmware"
