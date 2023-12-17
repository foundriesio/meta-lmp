do_create_flashlayout_tarball() {
    tar -chzf ${DEPLOY_DIR_IMAGE}/flashlayouts-${MACHINE}.tar.gz \
        -C ${DEPLOY_DIR_IMAGE} arm-trusted-firmware/ \
        fip/ \
        ${MFGTOOL_FLASH_IMAGE}.bin flashlayout_${IMAGE_BASENAME}/
}

python __anonymous () {
    machine = d.getVar("MACHINE", True)
    if machine.find('stm32mp1') != -1:
        tasks = filter(lambda k: d.getVarFlag(k, "task", True), d.keys())
        # Check that we have do_create_flashlayout_config() task added
        if 'do_create_flashlayout_config' in tasks:
            bb.build.addtask('do_create_flashlayout_tarball', 'do_build', 'do_create_flashlayout_config', d)
}
