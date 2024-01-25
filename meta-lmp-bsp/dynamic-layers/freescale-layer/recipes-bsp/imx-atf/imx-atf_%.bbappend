FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

PROVIDES += "virtual/trusted-firmware-a"
RPROVIDES:${PN} += "virtual-trusted-firmware-a"

SRC_URI:append = " \
    file://0001-plat-imx8m-obtain-boot-set-from-bootrom-even-log.patch \
"

SRC_URI:append:toradex = " \
    file://0001-Revert-Add-NXP-s-SoCs-partition-reboot-support.patch \
"

deploy_opteed_atf() {
    install -m 0644 ${S}/build-optee/${ATF_PLATFORM}/release/bl31.bin ${DEPLOYDIR}/arm-trusted-firmware.bin
    install -m 0644 ${S}/build-optee/${ATF_PLATFORM}/release/bl31/bl31.elf ${DEPLOYDIR}/arm-trusted-firmware.elf
}
do_deploy:append:mx8-nxp-bsp() {
    deploy_opteed_atf
}
do_deploy:append:mx9-nxp-bsp() {
    deploy_opteed_atf
}
