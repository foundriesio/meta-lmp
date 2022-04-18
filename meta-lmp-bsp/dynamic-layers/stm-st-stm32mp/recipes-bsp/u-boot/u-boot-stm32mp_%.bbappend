FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:stm32mp1-eval = " \
    file://0001-include-configs-stm32mp1-set-lmp-boot-cmd.patch \
"

SRC_URI:append:stm32mp1-disco = " \
    file://lmp.cfg \
"

# Drop work-shared usage, causes build race condition
STAGING_UBOOT_DIR = "${S}"
