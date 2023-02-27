FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

PROVIDES += "virtual/trusted-firmware-a"
RPROVIDES:${PN} += "virtual/trusted-firmware-a"

SRC_URI:append = " \
    file://0001-plat-imx8mp-implement-system_reset2.patch \
    file://0001-plat-imx8mp-SiP-call-for-secondary-boot.patch \
    file://0001-plat-imx8mn-implement-system_reset2.patch \
    file://0002-plat-imx8mn-SiP-call-for-secondary-boot.patch \
"

SRC_URI:append:toradex = " \
    file://0001-Revert-Add-NXP-s-SoCs-partition-reboot-support.patch \
"

do_deploy:append:mx8-nxp-bsp() {
    install -m 0644 ${S}/build-optee/${ATF_PLATFORM}/release/bl31.bin ${DEPLOYDIR}/arm-trusted-firmware.bin
    install -m 0644 ${S}/build-optee/${ATF_PLATFORM}/release/bl31/bl31.elf ${DEPLOYDIR}/arm-trusted-firmware.elf
}

#FIXME: when optee is enabled, replace build by build-optee
do_deploy:append:mx9-nxp-bsp() {
    install -m 0644 ${S}/build/${ATF_PLATFORM}/release/bl31.bin ${DEPLOYDIR}/arm-trusted-firmware.bin
    install -m 0644 ${S}/build/${ATF_PLATFORM}/release/bl31/bl31.elf ${DEPLOYDIR}/arm-trusted-firmware.elf
}
