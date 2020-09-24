FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# add pmu-firmware dependancy
DEPENDS_append_uz = "python3-native"

SRC_URI_append_uz = " \
    file://lmp.cfg \
    file://pm_cfg_obj.c \
"

# copy device-tree exported system files to source and generate pm_cfg_obj.bin
do_configure_append_uz() {
    cp ${WORKDIR}/pm_cfg_obj.c ${S}/
    cp ${RECIPE_SYSROOT}/boot/psu_init_gpl.c ${S}/
    cp ${RECIPE_SYSROOT}/boot/psu_init_gpl.h ${S}/
    ${PYTHON} ${S}/tools/zynqmp_pm_cfg_obj_convert.py ${S}/pm_cfg_obj.c ${S}/pm_cfg_obj.bin
    echo "CONFIG_ZYNQMP_SPL_PM_CFG_OBJ_FILE=\"${S}/pm_cfg_obj.bin\"" >> ${B}/.config
}

# make sure pmufw binary is deployed
do_configure[depends] += "virtual/pmu-firmware:do_deploy"

# Support additional u-boot classes such as u-boot-fitimage
UBOOT_CLASSES ?= ""
inherit ${UBOOT_CLASSES}
