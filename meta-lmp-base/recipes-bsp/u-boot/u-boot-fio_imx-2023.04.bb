require u-boot-fio-common.inc

UUU_BOOTLOADER = "uuu_bootloader_tag"
UUU_BOOTLOADER:mx8-generic-bsp = ""
UUU_BOOTLOADER:mx9-generic-bsp = ""
inherit_defer ${UUU_BOOTLOADER}

SRCREV = "d5bf13df210018527f8b0c136ce0b8be6b0d76f5"
SRCBRANCH = "2023.04+lf-6.1.55-2.2.0-fio"
LIC_FILES_CHKSUM = "file://Licenses/README;md5=2ca5f2c35c8cc335f0a19756634782f1"

DEFAULT_PREFERENCE = "-1"
