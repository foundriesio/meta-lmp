# Support additional firmware for NXP Wireless modules
#
# brcmfmac43455-sdio.txt and BCM4345C0.1MW.hcd for Murata 1MW on the i.MX8M Nano EVK
# are required for WiFi/BT support but not available in the linux-firmware repository.
#
# A code from meta-imx layer is used as a reference:
# https://source.codeaurora.org/external/imx/meta-imx/tree/meta-bsp/recipes-kernel/linux-firmware/linux-firmware_%25.bbappend?h=hardknott-5.10.52-2.1.0
#

IMX_FIRMWARE_BRANCH ?= "lf-5.15.71_2.2.0"
SRC_URI:append:imx-nxp-bsp = "\
    git://github.com/NXP/imx-firmware.git;protocol=https;branch=${IMX_FIRMWARE_BRANCH};destsuffix=imx-firmware;name=imx-firmware; \
"
SRCREV_imx-firmware ?= "982bb10dfabfb9e7b9dc106c59a4fbb2c45bfb44"
SRCREV_FORMAT = "imx-firmware"

do_install:append:imx-nxp-bsp () {
    # Drop upstream sdma firmware binaries (prefer from the BSP)
    if [ -d ${D}${base_libdir}/firmware/imx/sdma ]; then
        rm -rf ${D}${base_libdir}/firmware/imx/sdma
    fi

    # Install Murata 1MW NVRAM and HCD files
    install -m 0644 ${WORKDIR}/imx-firmware/cyw-wifi-bt/1MW_CYW43455/BCM4345C0.1MW.hcd ${D}${nonarch_base_libdir}/firmware/brcm/BCM4345C0.hcd
    install -m 0644 ${WORKDIR}/imx-firmware/cyw-wifi-bt/1MW_CYW43455/brcmfmac43455-sdio.txt ${D}${nonarch_base_libdir}/firmware/brcm/brcmfmac43455-sdio.fsl,${MACHINE}.txt

    # Install Murata CYW4356 firmware
    install -m 0644 ${WORKDIR}/imx-firmware/cyw-wifi-bt/1CX_CYW4356/brcmfmac4356-pcie.bin ${D}${nonarch_base_libdir}/firmware/brcm
    install -m 0644 ${WORKDIR}/imx-firmware/cyw-wifi-bt/1CX_CYW4356/brcmfmac4356-pcie.clm_blob ${D}${nonarch_base_libdir}/firmware/brcm
    install -m 0644 ${WORKDIR}/imx-firmware/cyw-wifi-bt/1CX_CYW4356/brcmfmac4356-pcie.txt ${D}${nonarch_base_libdir}/firmware/brcm
    install -m 0644 ${WORKDIR}/imx-firmware/cyw-wifi-bt/1CX_CYW4356/BCM4354A2.1CX.hcd ${D}${nonarch_base_libdir}/firmware/brcm/BCM4356A2.hcd
}

do_install:append:stm32mpcommon() {
    # Install calibration file (stm32mp15) for SCMI-ready machines
    install -m 0644 ${WORKDIR}/nvram-murata/cyfmac43430-sdio.1DX.txt ${D}${nonarch_base_libdir}/firmware/brcm/brcmfmac43430-sdio.st,stm32mp157c-dk2-scmi.txt
    install -m 0644 ${WORKDIR}/nvram-murata/cyfmac43430-sdio.1DX.txt ${D}${nonarch_base_libdir}/firmware/brcm/brcmfmac43430-sdio.st,stm32mp157f-dk2-scmi.txt

    # Set BFL3_EXT_LPO_ISCLOCK for wifi to work with upstream 5.15
    sed -i "s/^boardflags3=0x08/boardflags3=0x02/g" ${D}${nonarch_base_libdir}/firmware/brcm/brcmfmac43430-sdio.st,stm32mp157*
}

do_install:append() {
    # Avoid conflicts when wl18xx-fw is used instead by the target machine
    if ${@bb.utils.contains('MACHINE_EXTRA_RRECOMMENDS', 'wl18xx-fw', 'true', 'false', d)}; then
        rm -rf ${D}${nonarch_base_libdir}/firmware/ti-connectivity/wl18xx-fw-4.bin
    fi
}

FILES:${PN}-bcm43455 += " \
       ${nonarch_base_libdir}/firmware/brcm/BCM4345C0.hcd \
       ${nonarch_base_libdir}/firmware/brcm/brcmfmac43455-sdio.fsl,${MACHINE}.txt \
"

FILES:${PN}-bcm4356-pcie += " \
       ${nonarch_base_libdir}/firmware/brcm/brcmfmac4356-pcie.clm_blob \
       ${nonarch_base_libdir}/firmware/brcm/brcmfmac4356-pcie.txt \
       ${nonarch_base_libdir}/firmware/brcm/BCM4356A2.hcd \
"

PACKAGES:remove:imx-nxp-bsp = "${PN}-imx-sdma-license ${PN}-imx-sdma-imx6q ${PN}-imx-sdma-imx7d"
