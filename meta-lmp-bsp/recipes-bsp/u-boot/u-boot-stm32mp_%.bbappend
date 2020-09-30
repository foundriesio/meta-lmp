FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_stm32mp1-eval = " \
    file://0001-configs-stm32-enable-export-import-of-env.patch \
    file://0001-include-configs-stm32mp1-set-lmp-boot-cmd.patch \
"
