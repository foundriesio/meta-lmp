require u-boot-fio-common.inc

UUU_BOOTLOADER = "uuu_bootloader_tag"
UUU_BOOTLOADER:mx8-generic-bsp = ""
UUU_BOOTLOADER:mx9-generic-bsp = ""
inherit_defer ${UUU_BOOTLOADER}

SRCREV = "adbe53791d8f3cc2d7ecf2a3f308494d561def9e"
SRCBRANCH = "2024.04+lf-6.6.52-2.2.0-fio"
LIC_FILES_CHKSUM = "file://Licenses/README;md5=2ca5f2c35c8cc335f0a19756634782f1"

DEFAULT_PREFERENCE = "-1"
