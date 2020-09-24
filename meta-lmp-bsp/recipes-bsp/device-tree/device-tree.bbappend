FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_uz = " \
        file://system-som.dtsi \
        file://system-board.dtsi \
        file://system-conf.dtsi \
"
COMPATIBLE_MACHINE_uz = ".*"

do_configure_append_uz () {
        echo '/include/ "system-som.dtsi"' >> ${DT_FILES_PATH}/system-top.dts
        echo '/include/ "system-board.dtsi"' >> ${DT_FILES_PATH}/system-top.dts
        echo '/include/ "system-conf.dtsi"' >> ${DT_FILES_PATH}/system-top.dts
}

# make psu_init_gpl.* files available for u-boot
do_install_append () {
    install -Dm 0644 ${B}/device-tree/psu_init_gpl.h ${D}/boot/
    install -Dm 0644 ${B}/device-tree/psu_init_gpl.c ${D}/boot/
}

FILES_${PN} += "/boot/psu_init_gpl.h"
FILES_${PN} += "/boot/psu_init_gpl.c"
