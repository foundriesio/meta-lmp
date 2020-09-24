XSCTH_BUILD_DEBUG = "1"

# generate binary for u-boot
do_deploy_append() {
    mb-objcopy -O binary ${DEPLOYDIR}/${PN}-${MACHINE}.elf ${DEPLOYDIR}/${PN}-${MACHINE}.bin
}
