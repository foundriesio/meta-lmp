# Machine specific configuration

# Machines that were tested and known to work
COMPATIBLE_MACHINE = "(beaglebone-yocto|cl-som-imx7|colibri-imx7|cubox-i|hikey|dragonboard-410c|dragonboard-820c|rpi|stih410-b2260|intel-corei7-64|qemuriscv64|freedom-u540)"

# Generic configs for ARM
KBUILD_DEFCONFIG_aarch64 ?= "defconfig"
KBUILD_DEFCONFIG_armv7a ?= "multi_v7_defconfig"

# Generic configs for X86
KBUILD_DEFCONFIG_intel-corei7-64 ?= "x86_64_defconfig"
SRC_URI_append_intel-corei7-64 += " file://qemu-guest.scc file://qemu-guest.cfg file://intel.scc file://intel.cfg"

# Generic configs for RISC-V
KBUILD_DEFCONFIG_riscv64 ?= "defconfig"
SRC_URI_append_riscv64 += " file://riscv.scc file://riscv.cfg"
DEPENDS_append_riscv64 = " libgcc"
KERNEL_CC_append_riscv64 = " ${TOOLCHAIN_OPTIONS} ${SECURITY_NOPIE_CFLAGS}"
KERNEL_LD_append_riscv64 = " -no-pie"
## Freedom U540
SRC_URI_append_freedom-u540 += " file://freedom-u540.scc file://freedom-u540.cfg"
CMDLINE_freedom-u540 = "earlyprintk root=/dev/mmcblk0p2 rootwait console=ttySI0"

# Beagle
KBUILD_DEFCONFIG_beaglebone-yocto ?= "omap2plus_defconfig"

# iMX
KBUILD_DEFCONFIG_mx6 ?= "imx_v6_v7_defconfig"
KBUILD_DEFCONFIG_mx7 ?= "imx_v6_v7_defconfig"
SRC_URI_append_imx += " file://imx.scc file://imx.cfg"

# HiKey
SRC_URI_append_hikey += " file://hikey.scc file://hikey.cfg"

# Qcom (db410/db820c)
SRC_URI_append_dragonboard-410c += " file://qcom.scc file://qcom.cfg"
SRC_URI_append_dragonboard-820c += " file://qcom.scc file://qcom.cfg"

# Raspberry Pi
# No common rpi machine override available, need entries for every device
## TODO: Upstream a common override and uboot entrypoint
## Default kernel configs
KBUILD_DEFCONFIG_raspberrypi0-wifi ?= "bcmrpi_defconfig"
KBUILD_DEFCONFIG_raspberrypi ?= "bcmrpi_defconfig"
KBUILD_DEFCONFIG_raspberrypi2 ?= "bcm2709_defconfig"
KBUILD_DEFCONFIG_raspberrypi3 ?= "bcm2709_defconfig"
KBUILD_DEFCONFIG_raspberrypi3-64 ?= "bcmrpi3_defconfig"
UBOOT_ENTRYPOINT_RPI = "0x00008000"
KERNEL_EXTRA_ARGS_rpi += "LOADADDR=${UBOOT_ENTRYPOINT_RPI}"
## Raspberry Pi config fragment
SRC_URI_append_rpi += " file://rpi.scc file://rpi.cfg"

## Default cmdline
CMDLINE_rpi ?= "dwc_otg.lpm_enable=0 console=serial0,115200 root=/dev/mmcblk0p2 rootfstype=ext4 rootwait"

## Deploy cmdline.txt
do_deploy_append_rpi() {
    install -d ${DEPLOYDIR}/bcm2835-bootfiles
    echo "${CMDLINE}" > ${DEPLOYDIR}/bcm2835-bootfiles/cmdline.txt
}

## Build issues
## TODO: Validate if still required
do_compile_append_raspberrypi3-64() {
    cc_extra=$(get_cc_option)
    oe_runmake dtbs CC="${KERNEL_CC} $cc_extra " LD="${KERNEL_LD}" ${KERNEL_EXTRA_ARGS}
}

# ST
KERNEL_EXTRA_ARGS_stih410-b2260 += "LOADADDR=${ST_KERNEL_LOADADDR}"
