XSCTH_BUILD_DEBUG_uz = "1"

# generate executable binary for u-boot

do_compile_append_uz() {
    mb-objcopy -O binary ${B}/${XSCTH_PROJ}/${XSCTH_EXECUTABLE} ${B}/${XSCTH_PROJ}/executable.bin
}

do_install_append_uz() {
    install -Dm 0644 ${B}/${XSCTH_PROJ}/executable.bin ${D}/boot/${PN}-${SRCPV}.bin
}

do_deploy_append_uz() {
    install -Dm 0644 ${B}/${XSCTH_PROJ}/executable.bin ${DEPLOYDIR}/${XSCTH_BASE_NAME}.bin
    ln -sf ${XSCTH_BASE_NAME}.bin ${DEPLOYDIR}/${PN}-${MACHINE}.bin
}

FILES_${PN}_append_uz = " /boot/${PN}-${SRCPV}.bin"
