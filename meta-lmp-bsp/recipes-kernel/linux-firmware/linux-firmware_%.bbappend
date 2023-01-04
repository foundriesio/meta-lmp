# Support additional firmware for WiLink8 and NXP Wireless modules
#
# TIInit_11.8.32.bts is required for bluetooth support but this particular
# version is not available in the linux-firmware repository.
#
# sdiouart8987_combo_v0.bin is required for WiFi/BT support but this firmware
# is not available in the linux-firmware repository.
#
# brcmfmac43455-sdio.txt and BCM4345C0.1MW.hcd for Murata 1MW on the i.MX8M Nano EVK
# are required for WiFi/BT support but not available in the linux-firmware repository.
#
# A code from meta-imx layer is used as a reference:
# https://source.codeaurora.org/external/imx/meta-imx/tree/meta-bsp/recipes-kernel/linux-firmware/linux-firmware_%25.bbappend?h=hardknott-5.10.52-2.1.0
#
SRC_URI:append = "\
    https://git.ti.com/ti-bt/service-packs/blobs/raw/31a43dc1248a6c19bb886006f8c167e2fd21cb78/initscripts/TIInit_11.8.32.bts;name=TIInit_11.8.32 \
"

IMX_FIRMWARE_BRANCH ?= "lf-5.15.52_2.1.0"
SRC_URI:append:imx-nxp-bsp = "\
    git://github.com/NXP/imx-firmware.git;protocol=https;branch=${IMX_FIRMWARE_BRANCH};destsuffix=imx-firmware;name=imx-firmware; \
"
SRCREV_imx-firmware ?= "b6f070e3d4cab23932d9e6bc29e3d884a7fd68f4"

SRC_URI:append:beaglebone-yocto = "\
    https://github.com/beagleboard/beaglebone-black-wireless/raw/d9135000a223228158d92fd2e3f00e495f642fee/firmware/wl18xx-conf.bin;name=wl18xx-conf \
"

# WiLink8
SRC_URI[TIInit_11.8.32.sha256sum] = "398e9149225c19e73415463bbbf54dd8cbbb8dd1a595251519b828c0f8f50446"
SRC_URI[wl18xx-conf.sha256sum] = "e68e9a37995ab782faa41971704f24fd597d5abf16c47463708e90f8f080d335"

do_install:append() {
    cp ${WORKDIR}/TIInit_11.8.32.bts ${D}${nonarch_base_libdir}/firmware/ti-connectivity/
}

do_install:append:beaglebone-yocto() {
    cp ${WORKDIR}/wl18xx-conf.bin ${D}${nonarch_base_libdir}/firmware/ti-connectivity/
}

do_install:append:imx-nxp-bsp () {
    # Install NXP Connectivity
    install -d ${D}${nonarch_base_libdir}/firmware/nxp
    install -m 0644 ${WORKDIR}/imx-firmware/nxp/wifi_mod_para.conf    ${D}${nonarch_base_libdir}/firmware/nxp

    # Install NXP Connectivity 8987 firmware
    install -m 0644 ${WORKDIR}/imx-firmware/nxp/FwImage_8987/ed_mac_ctrl_V3_8987.conf  ${D}${nonarch_base_libdir}/firmware/nxp
    install -m 0644 ${WORKDIR}/imx-firmware/nxp/FwImage_8987/sdiouart8987_combo_v0.bin ${D}${nonarch_base_libdir}/firmware/nxp
    install -m 0644 ${WORKDIR}/imx-firmware/nxp/FwImage_8987/txpwrlimit_cfg_8987.conf  ${D}${nonarch_base_libdir}/firmware/nxp

    # Install NXP Connectivity 8997PCIE firmware
    install -m 0644 ${WORKDIR}/imx-firmware/nxp/FwImage_8997/ed_mac_ctrl_V3_8997.conf  ${D}${nonarch_base_libdir}/firmware/nxp
    install -m 0644 ${WORKDIR}/imx-firmware/nxp/FwImage_8997/pcieuart8997_combo_v4.bin ${D}${nonarch_base_libdir}/firmware/nxp
    install -m 0644 ${WORKDIR}/imx-firmware/nxp/FwImage_8997/txpwrlimit_cfg_8997.conf  ${D}${nonarch_base_libdir}/firmware/nxp

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
    # Set BFL3_EXT_LPO_ISCLOCK for wifi to work with upstream 5.15
    sed -i "s/^boardflags3=0x08/boardflags3=0x02/g" ${D}${nonarch_base_libdir}/firmware/brcm/brcmfmac43430-sdio.st,stm32mp157*
}

PACKAGES =+ "${PN}-nxp89xx"

FILES:${PN}-nxp89xx = " \
       ${nonarch_base_libdir}/firmware/nxp/ed_mac_ctrl_V3_8987.conf \
       ${nonarch_base_libdir}/firmware/nxp/sdiouart8987_combo_v0.bin \
       ${nonarch_base_libdir}/firmware/nxp/txpwrlimit_cfg_8987.conf \
       ${nonarch_base_libdir}/firmware/nxp/ed_mac_ctrl_V3_8997.conf \
       ${nonarch_base_libdir}/firmware/nxp/pcieuart8997_combo_v4.bin \
       ${nonarch_base_libdir}/firmware/nxp/txpwrlimit_cfg_8997.conf \
       ${nonarch_base_libdir}/firmware/nxp/wifi_mod_para.conf \
"

FILES:${PN}-bcm43455 += " \
       ${nonarch_base_libdir}/firmware/brcm/BCM4345C0.hcd \
       ${nonarch_base_libdir}/firmware/brcm/brcmfmac43455-sdio.fsl,${MACHINE}.txt \
"

FILES:${PN}-bcm4356-pcie += " \
       ${nonarch_base_libdir}/firmware/brcm/brcmfmac4356-pcie.clm_blob \
       ${nonarch_base_libdir}/firmware/brcm/brcmfmac4356-pcie.txt \
       ${nonarch_base_libdir}/firmware/brcm/BCM4356A2.hcd \
"
