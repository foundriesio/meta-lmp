FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:stm32mp1common = " \
     file://0001-feat-stm32mp1-save-boot-auth-status-and-partition-in.patch \
     file://0002-feat-stm32mp1-check-for-fip-a-fip-b-partitions.patch \
     file://0004-refactor-mmc-export-user-boot-partition-switch-funct.patch \
     file://0005-feat-stm32mp1-extend-STM32MP_EMMC_BOOT-support-to-FI.patch \
     "

SRC_URI:append:sota:stm32mp1common = " \
     file://0003-FIO-interal-stm32mp1-support-for-boot-script-in-FIP.patch \
     "
