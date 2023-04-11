# Copyright 2022 NXP
# Released under the MIT license (see COPYING.MIT for the terms)

DESCRIPTION = "i.MX M33 core demo images"
SECTION = "BSP"
LICENSE = "Proprietary"
LIC_FILES_CHKSUM = "file://COPYING;md5=5a0bf11f745e68024f37b4724a5364fe"

inherit deploy fsl-eula-unpack

SOC ?= "INVALID"
SOC:mx8ulp-nxp-bsp = "imx8ulp"
SOC:mx93-nxp-bsp = "imx93"

MCORE_TYPE = "m33"

SRC_URI = "${FSL_MIRROR}/${SOC}-${MCORE_TYPE}-demo-${PV}.bin;name=${SOC};fsl-eula=true"

S = "${WORKDIR}/${SOC}-${MCORE_TYPE}-demo-${PV}"

SRC_URI[imx8ulp.md5sum] = "7a4c8e667749d429f57a64cefc096d0e"
SRC_URI[imx8ulp.sha256sum] = "40d6184e50e5dfad78973ccf4da9fdd221737558b5ed8963167b6fd81e6752c4"

SRC_URI[imx93.md5sum] = "b63358a6ed6f2b95c8196c54140b4a23"
SRC_URI[imx93.sha256sum] = "e87cd109bf4a20c5f28ea9e927d300f59386c0e2edeef95e2e3496882101469f"

PACKAGE_ARCH = "${MACHINE_SOCARCH}"

do_configure[noexec] = "1"
do_compile[noexec] = "1"

do_install () {
    install -d ${D}${nonarch_base_libdir}/firmware
    install -m 0644 ${S}/*.elf ${D}${nonarch_base_libdir}/firmware
}

do_deploy () {
    install -m 0644 ${S}/*.bin ${DEPLOYDIR}/
}

addtask deploy after do_install

FILES:${PN} = "${nonarch_base_libdir}/firmware"

INSANE_SKIP:${PN} = "arch"

COMPATIBLE_MACHINE = "(mx8ulp-nxp-bsp|mx93-nxp-bsp)"
