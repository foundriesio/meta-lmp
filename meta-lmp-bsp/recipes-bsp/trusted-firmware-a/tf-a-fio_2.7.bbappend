FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:stm32mp1common = " \
     file://0001-feat-stm32mp1-save-boot-auth-status-and-partition-in.patch \
     file://0002-feat-stm32mp1-check-for-fip-a-fip-b-partitions.patch \
     file://0003-FIO-interal-stm32mp1-support-for-boot-script-in-FIP.patch \
     "
