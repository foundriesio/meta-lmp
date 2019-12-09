# Machine specific configuration

# QEMU
KERNEL_FEATURES_remove_qemuall = "features/kernel-sample/kernel-sample.scc"

## Required to generate correct dtb files
do_compile_append_rpi() {
    if [ "${SITEINFO_BITS}" = "64" ]; then
        cc_extra=$(get_cc_option)
        oe_runmake dtbs CC="${KERNEL_CC} $cc_extra " LD="${KERNEL_LD}" ${KERNEL_EXTRA_ARGS}
    fi
}
