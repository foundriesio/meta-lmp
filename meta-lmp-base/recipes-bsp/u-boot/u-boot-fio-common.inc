HOMEPAGE = "http://www.denx.de/wiki/U-Boot/WebHome"
DESCRIPTION = "U-Boot, a boot loader for Embedded boards based on PowerPC, \
ARM, MIPS and several other processors, which can be installed in a boot \
ROM and used to initialize and test the hardware or to download and run \
application code."
SECTION = "bootloaders"
LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://Licenses/README;md5=30503fd321432fc713238f582193b78e"
DEPENDS += "flex-native bison-native bc-native dtc-native python3-setuptools-native"

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

do_compile_append() {
    cat << EOF > sit_template
#! /usr/bin/perl -w
use strict;

open(my \$out, '>:raw', 'sit.bin') or die "Unable to open: $!";
print \$out pack("V", 0x0);	# chipnum
print \$out pack("V", 0x0);	# driver type
print \$out pack("V", 0x00112233);	# tag
print \$out pack("V", %sectornum%);	# firstSectorNumber
print \$out pack("V", 0x0);	# Sector count, not used
close(\$out);

EOF
    if [ -n "${UBOOT_CONFIG}" ]; then
        for config in ${UBOOT_MACHINE}; do
            for type in ${UBOOT_CONFIG}; do
                SECONDARY_OFFSET=$(printf "%d" $(grep -e CONFIG_SECONDARY_BOOT_SECTOR_OFFSET ${B}/${config}/.config | sed 's/=/ /g' | awk '{print $2}'))
                if [ "${SECONDARY_OFFSET}" != "0" ]; then
                    bbnote "Building Secondary Image Table, firstSectorNumber = ${SECONDARY_OFFSET}"
                    sed -e s/%sectornum%/${SECONDARY_OFFSET}/g sit_template > sit_gen
                    chmod +x sit_gen
                    ./sit_gen
                    objcopy -I binary -O binary --pad-to 512 ${B}/${config}/sit-${type}.bin
                    unset SECONDARY_OFFSET
                fi
            done
        done
    else
        SECONDARY_OFFSET=$(printf "%d" $(grep -e CONFIG_SECONDARY_BOOT_SECTOR_OFFSET ${B}/.config | sed 's/=/ /g' | awk '{print $2}'))
        if [ "${SECONDARY_OFFSET}" != "0" ]; then
            bbnote "Building Secondary Image Table, firstSectorNumber = ${SECONDARY_OFFSET}"
            sed -e s/%sectornum%/${SECONDARY_OFFSET}/g sit_template > sit_gen
            chmod +x sit_gen
            ./sit_gen
            objcopy -I binary -O binary --pad-to 512 ${B}/sit.bin
        fi
    fi
}

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
                    if [ -f ${B}/${config}/sit-${type}.bin ]; then
                        install -D -m 644 ${B}/${config}/sit-${type}.bin ${DEPLOYDIR}/${PN}-sit.bin-${MACHINE}-${type}-${PV}-${PR}
                        cd ${DEPLOYDIR}
                        ln -sf ${PN}-sit.bin-${MACHINE}-${type}-${PV}-${PR} ${PN}-sit.bin-${MACHINE}-${type}
                        ln -sf ${PN}-sit.bin-${MACHINE}-${type}-${PV}-${PR} sit-${MACHINE}-${type}.bin
                        ln -sf ${PN}-sit.bin-${MACHINE}-${type}-${PV}-${PR} ${PN}-sit.bin-${type}
                    fi
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
        if [ -f ${B}/sit.bin ]; then
            install -D -m 644 ${B}/sit.bin ${DEPLOYDIR}/${PN}-sit.bin-${MACHINE}-${PV}-${PR}
            cd ${DEPLOYDIR}
            ln -sf ${PN}-sit.bin-${MACHINE}-${PV}-${PR} ${PN}-sit.bin-${MACHINE}
            ln -sf ${PN}-sit.bin-${MACHINE}-${PV}-${PR} sit-${MACHINE}.bin
            ln -sf ${PN}-sit.bin-${MACHINE}-${PV}-${PR} ${PN}-sit.bin
        fi
    fi
}
