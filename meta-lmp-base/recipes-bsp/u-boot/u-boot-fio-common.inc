HOMEPAGE = "http://www.denx.de/wiki/U-Boot/WebHome"
DESCRIPTION = "U-Boot, a boot loader for Embedded boards based on PowerPC, \
ARM, MIPS and several other processors, which can be installed in a boot \
ROM and used to initialize and test the hardware or to download and run \
application code."
SECTION = "bootloaders"
LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://Licenses/README;md5=30503fd321432fc713238f582193b78e"
DEPENDS += "flex-native bison-native bc-native dtc-native"

SRC_URI = "git://github.com/foundriesio/u-boot.git;branch=${SRCBRANCH} \
    file://fw_env.config \
    file://lmp.cfg \
"
# LMP base requires a different u-boot configuration fragment
SRC_URI_append_lmp-base = " file://lmp-base.cfg "
SRC_URI_remove_lmp-base = "file://lmp.cfg"

S = "${WORKDIR}/git"
B = "${WORKDIR}/build"
do_configure[cleandirs] = "${B}"

require recipes-bsp/u-boot/u-boot.inc

# Support additional u-boot classes such as u-boot-fitimage
UBOOT_CLASSES ?= ""
inherit ${UBOOT_CLASSES} fio-u-boot-localversion

PROVIDES += "u-boot"

# Also deploy u-boot config used during build
do_deploy_append() {
    if [ -n "${UBOOT_CONFIG}" ]; then
        for config in ${UBOOT_MACHINE}; do
            i=$(expr $i + 1);
            for type in ${UBOOT_CONFIG}; do
                j=$(expr $j + 1);
                if [ $j -eq $i ]; then
                    install -D -m 644 ${B}/${config}/.config ${DEPLOYDIR}/${PN}-config-${MACHINE}-${type}-${PV}-${PR}
                    cd ${DEPLOYDIR}
                    ln -sf ${PN}-config-${MACHINE}-${type}-${PV}-${PR} ${PN}-config-${MACHINE}-${type}
                    ln -sf ${PN}-config-${MACHINE}-${type}-${PV}-${PR} ${PN}-config-${type}
                fi
            done
            unset j
        done
        unset i
    else
        install -D -m 644 ${B}/.config ${DEPLOYDIR}/${PN}-config-${MACHINE}-${PV}-${PR}
        cd ${DEPLOYDIR}
        ln -sf ${PN}-config-${MACHINE}-${PV}-${PR} ${PN}-config-${MACHINE}
        ln -sf ${PN}-config-${MACHINE}-${PV}-${PR} ${PN}-config
    fi
}
