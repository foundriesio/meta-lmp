# Copyright 2022 NXP
# Released under the MIT license (see COPYING.MIT for the terms)

DESCRIPTION = "i.MX M33 core demo images"
SECTION = "BSP"
LICENSE = "Proprietary"
LIC_FILES_CHKSUM = "file://COPYING;md5=ea25d099982d035af85d193c88a1b479"

inherit deploy fsl-eula-unpack

SOC ?= "INVALID"
SOC:mx8ulp-nxp-bsp = "imx8ulp"
SOC:mx93-nxp-bsp = "imx93"

MCORE_TYPE = "m33"

SRC_URI = "${FSL_MIRROR}/${SOC}-${MCORE_TYPE}-demo-${PV}.bin;name=${SOC};fsl-eula=true"

S = "${WORKDIR}/${SOC}-${MCORE_TYPE}-demo-${PV}"

SRC_URI[imx8ulp.md5sum] = "f76e829152d3d704b3e16d96a077aac2"
SRC_URI[imx8ulp.sha256sum] = "83e8612e687fa337e763152bc1a9add1cbf154cc19b329273d5f74252ebfb1b2"

SRC_URI[imx93.md5sum] = "dd9d0d8b46c089f1f9dd61ba4f8e7d18"
SRC_URI[imx93.sha256sum] = "c6f6c13abba24dcc92e1015674850c86785b9ab60f4e32ccc0aae939d277e16f"

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
