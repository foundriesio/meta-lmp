FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:stm32mp1common = " \
     file://0001-feat-stm32mp1-save-boot-auth-status-and-partition-in.patch \
     file://0002-feat-stm32mp1-check-for-fip-a-fip-b-partitions.patch \
     file://0004-refactor-mmc-export-user-boot-partition-switch-funct.patch \
     file://0005-feat-stm32mp1-extend-STM32MP_EMMC_BOOT-support-to-FI.patch \
     file://0006-feat-mmc-get-boot-partition-size.patch \
     file://0007-fix-st-add-max-size-for-FIP-in-eMMC-boot-part.patch \
     file://0001-auth-tbbr-move-firmware-configuration-into-common-pa.patch \
     file://0002-mbedtls-fconf-fix-compile-warning.patch \
     file://0003-fdts-stm32mp15_bl2-add-the-trusted-boot-configuratio.patch \
     file://0004-plat-stm32mp1-add-trusted-boot-support.patch \
     file://0005-feat-stm32mp-anti-rollback-for-TBB.patch \
     "

SRC_URI:append:sota:stm32mp1common = " \
     file://0003-FIO-interal-stm32mp1-support-for-boot-script-in-FIP.patch \
     "

SRC_URI:append:stm32mp1common = " file://0001-Binutils-2.39-now-warns-when-a-segment-has-RXW-permi.patch"
