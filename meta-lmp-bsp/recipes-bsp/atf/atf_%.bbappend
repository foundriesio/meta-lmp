do_deploy_append_qemuarm64() {
    ln -sf ../optee/tee-header_v2.bin ${DEPLOYDIR}/atf/bl32.bin
    ln -sf ../optee/tee-pager_v2.bin ${DEPLOYDIR}/atf/bl32_extra1.bin
    ln -sf ../optee/tee-pageable_v2.bin ${DEPLOYDIR}/atf/bl32_extra2.bin
    ln -sf ../u-boot.bin ${DEPLOYDIR}/atf/bl33.bin
}
