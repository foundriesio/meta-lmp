FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRCBRANCH = "lf_v2.4"
# lf-5.10.72-2.2.0
SRCREV = "5782363f92a2fdf926784449270433cf3ddf44bd"

PROVIDES += "virtual/trusted-firmware-a"
RPROVIDES:${PN} += "virtual/trusted-firmware-a"

SRC_URI:append = " \
    file://0002-plat-imx8m-add-SiP-call-for-SRC-PERSIST_SECONDARY_BO.patch \
    file://0003-feat-plat-imx8m-add-system_reset2-implementation.patch \
    file://0001-plat-imx8mp-implement-system_reset2.patch \
    file://0004-plat-imx8mq-SiP-call-for-secondary-boot.patch \
    file://0001-plat-imx8mp-SiP-call-for-secondary-boot.patch \
"

SRC_URI:append:toradex = " \
    file://0001-Revert-Add-NXP-s-SoCs-partition-reboot-support.patch \
"

do_deploy:append:mx8() {
    install -m 0644 ${S}/build-optee/${ATF_PLATFORM}/release/bl31.bin ${DEPLOYDIR}/arm-trusted-firmware.bin
    install -m 0644 ${S}/build-optee/${ATF_PLATFORM}/release/bl31/bl31.elf ${DEPLOYDIR}/arm-trusted-firmware.elf
}
