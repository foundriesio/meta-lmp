do_create_flashlayout_tarball() {
    tar -chzf ${DEPLOY_DIR_IMAGE}/flashlayouts-${MACHINE}.tar.gz \
        -C ${DEPLOY_DIR_IMAGE} --transform "s|^|flashlayouts-stm32mp1/|" arm-trusted-firmware/ \
        fip/ \
        ${MFGTOOL_FLASH_IMAGE}.bin flashlayout_${IMAGE_BASENAME}/
}

python __anonymous () {
    if 'stm32mp1common' in d.getVar('MACHINEOVERRIDES').split(':'):
        tasks = filter(lambda k: d.getVarFlag(k, "task", True), d.keys())
        # Check that we have do_create_flashlayout_config() task added
        if 'do_create_flashlayout_config' in tasks:
            bb.build.addtask('do_create_flashlayout_tarball', 'do_build', 'do_create_flashlayout_config', d)
}
