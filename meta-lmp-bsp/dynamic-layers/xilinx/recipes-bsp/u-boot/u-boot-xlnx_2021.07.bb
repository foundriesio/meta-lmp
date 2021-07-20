UBOOT_VERSION = "v2021.07"

UBRANCH = "xilinx-v2021.07-bsp"
UBOOTURI = "git://github.com/foundriesio/u-boot.git;protocol=https"

SRCREV = "67197d5a1df47d98066a8f65999257d54d08eb4b"

include recipes-bsp/u-boot/u-boot-xlnx.inc
include recipes-bsp/u-boot/u-boot-spl-zynq-init.inc

LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://README;beginline=1;endline=4;md5=744e7e3bb0c94b4b9f6b3db3bf893897"

# u-boot-xlnx has support for these
HAS_PLATFORM_INIT ?= " \
		xilinx_zynqmp_virt_config \
		xilinx_zynq_virt_defconfig \
		xilinx_versal_vc_p_a2197_revA_x_prc_01_revA \
		"

# add pmu-firmware and fpga bitstream (loading FPGA from SPL) dependancies
do_compile[depends] += "virtual/pmu-firmware:do_deploy bitstream-extraction:do_deploy"

SRC_URI_append = " \
    file://fw_env.config \
    file://lmp.cfg \
    ${@bb.utils.contains('MACHINE_FEATURES', 'ebbr', 'file://lmp-ebbr.cfg', '', d)} \
"

# LMP base requires a different u-boot configuration fragment
SRC_URI_append_lmp-base = " file://lmp-base.cfg "
SRC_URI_remove_lmp-base = "file://lmp.cfg"

SRC_URI_append_uz = " \
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
LOCALVERSION = "+xlnx"
inherit ${UBOOT_CLASSES} fio-u-boot-localversion
