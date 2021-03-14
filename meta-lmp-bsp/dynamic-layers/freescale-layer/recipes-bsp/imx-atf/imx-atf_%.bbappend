FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

PROVIDES += "virtual/trusted-firmware-a"
RPROVIDES_${PN} += "virtual/trusted-firmware-a"

SRC_URI_append = " \
    file://0002-plat-imx8m-add-SiP-call-for-SRC-PERSIST_SECONDARY_BO.patch \
    file://0003-plat-imx8m-add-SiP-call-for-triggering-internal-warm.patch \
"

SRC_URI_append_toradex = " \
    file://0001-Revert-Add-NXP-s-SoCs-partition-reboot-support.patch \
"

do_deploy_append_mx8m() {
    install -m 0644 ${S}/build-optee/${PLATFORM}/release/bl31.bin ${DEPLOYDIR}/arm-trusted-firmware.bin
    install -m 0644 ${S}/build-optee/${PLATFORM}/release/bl31/bl31.elf ${DEPLOYDIR}/arm-trusted-firmware.elf
}
