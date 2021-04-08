FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_stm32mp1-eval = " \
    file://0001-include-configs-stm32mp1-set-lmp-boot-cmd.patch \
"

SRC_URI_append_stm32mp1-disco = " \
    file://lmp.cfg \
"
