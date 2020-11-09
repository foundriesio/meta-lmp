FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

inherit xilinx-platform-init

PROVIDES_append_uz = " virtual/xilinx-platform-init"

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

do_install_append_uz () {
	install -d ${D}${PLATFORM_INIT_DIR}
	for i in ${PLATFORM_INIT_FILES}; do
		install -m 0644 ${B}/device-tree/$i ${D}${PLATFORM_INIT_DIR}/
	done
}

SYSROOT_PREPROCESS_FUNCS += "dtb_sysroot_preprocess"
dtb_sysroot_preprocess () {
	if [ -n "${PLATFORM_INIT_DIR}" ] && [ -d ${D}${PLATFORM_INIT_DIR} ]; then
		install -d ${SYSROOT_DESTDIR}${PLATFORM_INIT_DIR}
		for i in ${PLATFORM_INIT_FILES}; do
			install -m 0644 ${D}${PLATFORM_INIT_DIR}/$i ${SYSROOT_DESTDIR}${PLATFORM_INIT_DIR}/
		done
	fi
}

PACKAGES_append_uz = " ${PN}-platform-init"
FILES_${PN}-platform-init = "${PLATFORM_INIT_DIR}/*"
