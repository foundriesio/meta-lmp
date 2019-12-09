require u-boot-fio-common.inc
require recipes-bsp/u-boot/u-boot.inc

DEPENDS += "bc-native dtc-native"

# Board specific configuration
SRC_URI_append = " file://lmp.cfg"

# Support additional u-boot classes such as u-boot-fitimage
UBOOT_CLASSES ?= ""
inherit ${UBOOT_CLASSES}

RDEPENDS_${PN}_append_sota = " u-boot-ostree-scr"

PROVIDES += "u-boot"
