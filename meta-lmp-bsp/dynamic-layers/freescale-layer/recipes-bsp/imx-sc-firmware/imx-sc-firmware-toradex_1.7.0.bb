# Copyright (C) 2016 Freescale Semiconductor
# Copyright (C) 2017-2019 NXP
# Copyright (C) 2020 Toradex

DESCRIPTION = "i.MX System Controller Firmware for Toradex hardware"
LICENSE = "Proprietary"
LIC_FILES_CHKSUM = "file://COPYING;md5=94c5a3fc041e195df67fde3979a5e14e"
SECTION = "BSP"

inherit deploy

SRC_URI = "git://github.com/toradex/i.MX-System-Controller-Firmware.git;branch=master;protocol=https;fsl-eula=true"

SRCREV = "60d8c942f49012b6620f34800e2e9f11e45a9ef5"
SRCREV_use-head-next = "${AUTOREV}"

S = "${WORKDIR}/git"

PROVIDES = "imx-sc-firmware"
RREPLACES:${PN} = "imx-sc-firmware"
RPROVIDES:${PN} = "imx-sc-firmware"
RCONFLICTS:${PN} = "imx-sc-firmware"

BOARD_TYPE ?= "unknown"
SC_FIRMWARE_NAME:mx8qm-nxp-bsp = "mx8qm-${BOARD_TYPE}-scfw-tcm.bin"
SC_FIRMWARE_NAME:mx8qxp-nxp-bsp = "mx8qx-${BOARD_TYPE}-scfw-tcm.bin"
symlink_name = "scfw_tcm.bin"

BOOT_TOOLS = "imx-boot-tools"

do_compile[noexec] = "1"

do_install[noexec] = "1"

do_deploy() {
    install -Dm 0644 ${S}/src/scfw_export_*/build_*/${SC_FIRMWARE_NAME} ${DEPLOYDIR}/${BOOT_TOOLS}/${SC_FIRMWARE_NAME}
    ln -sf ${SC_FIRMWARE_NAME} ${DEPLOYDIR}/${BOOT_TOOLS}/${symlink_name}
}
addtask deploy after do_install

INHIBIT_PACKAGE_STRIP = "1"
INHIBIT_PACKAGE_DEBUG_SPLIT = "1"
PACKAGE_ARCH = "${MACHINE_ARCH}"

COMPATIBLE_MACHINE = "(apalis-imx8.*|colibri-imx8.*)"
