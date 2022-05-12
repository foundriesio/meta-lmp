FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:kv260 = " \
        file://0001-zynqmp-2022.1-optee-firmware-node.patch \
"

# From xilinx-k26-starterkit-2021.1/project-spec/dts_dir
EXTRA_DT_FILES:kv260 = " \
	zynqmp-sck-kv-g-dp.dts \
	zynqmp-sck-kv-g-rev1.dts \
	zynqmp-sck-kv-g-revA.dts \
	zynqmp-sck-kv-g-revB.dts \
	zynqmp-sck-kv-g-revY.dts \
	zynqmp-sck-kv-g-revZ.dts \
"

inherit xilinx-platform-init

PROVIDES:append:zynqmp = " virtual/xilinx-platform-init"

SRC_URI:append:uz = " \
        file://system-som.dtsi \
        file://system-board.dtsi \
        file://system-conf.dtsi \
"
COMPATIBLE_MACHINE:zynqmp = ".*"

do_configure:append:uz () {
        echo '/include/ "system-som.dtsi"' >> ${DT_FILES_PATH}/system-top.dts
        echo '/include/ "system-board.dtsi"' >> ${DT_FILES_PATH}/system-top.dts
        echo '/include/ "system-conf.dtsi"' >> ${DT_FILES_PATH}/system-top.dts
}

do_install:append:zynqmp () {
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

PACKAGES:append:zynqmp = " ${PN}-platform-init"
FILES:${PN}-platform-init = "${PLATFORM_INIT_DIR}/*"
