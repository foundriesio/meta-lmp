require u-boot-fio-common.inc

UUU_BOOTLOADER_TAG = ""
UUU_BOOTLOADER_TAG:imx-generic-bsp = "uuu_bootloader_tag"
UUU_BOOTLOADER_TAG:mx8-generic-bsp = ""
UUU_BOOTLOADER_TAG:mx9-generic-bsp = ""
inherit_defer ${UUU_BOOTLOADER_TAG}

SRCREV = "bb07913571ef1763fd3dab44bfbbd4e95fdcab57"
SRCBRANCH = "2024.04+lf-6.6.52-2.2.1-fio"
LIC_FILES_CHKSUM = "file://Licenses/README;md5=2ca5f2c35c8cc335f0a19756634782f1"

DEFAULT_PREFERENCE = "-1"
