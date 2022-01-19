FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

inherit xilinx-platform-init

PROVIDES:append:uz = " virtual/xilinx-platform-init"

SRC_URI:append:uz = " \
        file://system-som.dtsi \
        file://system-board.dtsi \
        file://system-conf.dtsi \
"
COMPATIBLE_MACHINE:uz = ".*"

do_configure:append:uz () {
        echo '/include/ "system-som.dtsi"' >> ${DT_FILES_PATH}/system-top.dts
        echo '/include/ "system-board.dtsi"' >> ${DT_FILES_PATH}/system-top.dts
        echo '/include/ "system-conf.dtsi"' >> ${DT_FILES_PATH}/system-top.dts
}

do_install:append:uz () {
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

PACKAGES:append:uz = " ${PN}-platform-init"
FILES:${PN}-platform-init = "${PLATFORM_INIT_DIR}/*"
