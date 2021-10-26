FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

# lf-5.10.52-2.1.0
SRCREV = "bb4957067d4b96a6ee197a333425948e409e990d"

PROVIDES += "virtual/trusted-firmware-a"
RPROVIDES_${PN} += "virtual/trusted-firmware-a"

SRC_URI_append = " \
    file://0002-plat-imx8m-add-SiP-call-for-SRC-PERSIST_SECONDARY_BO.patch \
    file://0003-feat-plat-imx8m-add-system_reset2-implementation.patch \
    file://0004-plat-imx8mq-SiP-call-for-secondary-boot.patch \
"

SRC_URI_append_toradex = " \
    file://0001-Revert-Add-NXP-s-SoCs-partition-reboot-support.patch \
"

do_deploy_append_mx8() {
    install -m 0644 ${S}/build-optee/${ATF_PLATFORM}/release/bl31.bin ${DEPLOYDIR}/arm-trusted-firmware.bin
    install -m 0644 ${S}/build-optee/${ATF_PLATFORM}/release/bl31/bl31.elf ${DEPLOYDIR}/arm-trusted-firmware.elf
}
