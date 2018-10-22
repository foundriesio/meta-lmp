# Machine specific configuration

# Machines that were tested and known to work
COMPATIBLE_MACHINE = "(beaglebone-yocto|cl-som-imx7|colibri-imx7|cubox-i|hikey|hikey960|dragonboard-410c|dragonboard-820c|rpi|intel-corei7-64|qemuriscv64|freedom-u540)"

# Generic configs for RISC-V
DEPENDS_append_riscv64 = " libgcc"
KERNEL_CC_append_riscv64 = " ${TOOLCHAIN_OPTIONS} ${SECURITY_NOPIE_CFLAGS}"
KERNEL_LD_append_riscv64 = " -no-pie"
## Freedom U540
CMDLINE_freedom-u540 = "earlyprintk root=/dev/mmcblk0p2 rootwait console=ttySI0"

# QEMU
KERNEL_FEATURES_remove_qemuall = "features/kernel-sample/kernel-sample.scc"

# Raspberry Pi
## Default cmdline
SERIAL_rpi = "${@oe.utils.conditional("ENABLE_UART", "1", "console=serial0,115200", "", d)}"
CMDLINE_rpi ?= "dwc_otg.lpm_enable=0 ${SERIAL} rootwait"

## Deploy cmdline.txt
do_deploy_append_rpi() {
    install -d ${DEPLOYDIR}/bcm2835-bootfiles
    echo "${CMDLINE}" > ${DEPLOYDIR}/bcm2835-bootfiles/cmdline.txt
}

## Required to generate correct dtb files
do_compile_append_raspberrypi3-64() {
    cc_extra=$(get_cc_option)
    oe_runmake dtbs CC="${KERNEL_CC} $cc_extra " LD="${KERNEL_LD}" ${KERNEL_EXTRA_ARGS}
}
