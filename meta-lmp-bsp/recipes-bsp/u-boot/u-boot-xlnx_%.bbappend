FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# add pmu-firmware dependancy
DEPENDS_append_uz = "virtual/pmu-firmware"

SRC_URI_append = " \
    file://0001-arm-zynqmp-add-support-to-handoff-bl32-parameters.patch \
    file://0001-board-zynqmp-subtract-optee-runtime-length-from-ram_.patch \
"

SRC_URI_append_uz = " \
    file://lmp.cfg \
    file://pm_cfg_obj.c \
"

# copy platform files to u-boot source dir
do_configure_prepend() {
    if [ -n "${PLATFORM_INIT_DIR}" ]; then
        for i in ${PLATFORM_INIT_FILES}; do
            cp ${PLATFORM_INIT_STAGE_DIR}/$i ${S}/
        done
    fi
}

# generate and configure u-boot to use pm_cfg_obj.bin
do_compile_prepend_uz() {
    ${PYTHON} ${S}/tools/zynqmp_pm_cfg_obj_convert.py ${WORKDIR}/pm_cfg_obj.c ${S}/pm_cfg_obj.bin
    echo "CONFIG_ZYNQMP_SPL_PM_CFG_OBJ_FILE=\"${S}/pm_cfg_obj.bin\"" >> ${B}/.config
}

# Support additional u-boot classes such as u-boot-fitimage
UBOOT_CLASSES ?= ""
inherit ${UBOOT_CLASSES}
