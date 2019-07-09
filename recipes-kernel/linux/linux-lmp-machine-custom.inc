# Machine specific configuration

# Machines that were tested and known to work
COMPATIBLE_MACHINE = "(apalis-imx6|beaglebone-yocto|cl-som-imx7|colibri-imx7|cubox-i|hikey|hikey960|rpi|intel-corei7-64|qemuarm64|qemuriscv64|freedom-u540)"

# Generic configs for RISC-V
DEPENDS_append_riscv64 = " libgcc"
KERNEL_CC_append_riscv64 = " ${TOOLCHAIN_OPTIONS} ${SECURITY_NOPIE_CFLAGS}"
KERNEL_LD_append_riscv64 = " -no-pie"

# QEMU
KERNEL_FEATURES_remove_qemuall = "features/kernel-sample/kernel-sample.scc"

## Required to generate correct dtb files
do_compile_append_raspberrypi3-64() {
    cc_extra=$(get_cc_option)
    oe_runmake dtbs CC="${KERNEL_CC} $cc_extra " LD="${KERNEL_LD}" ${KERNEL_EXTRA_ARGS}
}
