# Common include for all LMP u-boot recipes

# Also deploy u-boot config used during build
do_deploy_append() {
    if [ -n "${UBOOT_CONFIG}" ]; then
        for config in ${UBOOT_MACHINE}; do
            machine_idx=$(expr $machine_idx + 1);
            for type in ${UBOOT_CONFIG}; do
                type_idx=$(expr $type_idx + 1);
                if [ $type_idx -eq $machine_idx ]; then
                    install -D -m 644 ${B}/${config}/.config ${DEPLOYDIR}/${PN}-config-${MACHINE}-${type}-${PV}-${PR}
                    cd ${DEPLOYDIR}
                    ln -sf ${PN}-config-${MACHINE}-${type}-${PV}-${PR} ${PN}-config-${MACHINE}-${type}
                    ln -sf ${PN}-config-${MACHINE}-${type}-${PV}-${PR} ${PN}-config-${type}
                    if [ -f ${B}/${config}/sit-${type}.bin ]; then
                        install -D -m 644 ${B}/${config}/sit-${type}.bin ${DEPLOYDIR}/${PN}-sit.bin-${MACHINE}-${type}-${PV}-${PR}
                        cd ${DEPLOYDIR}
                        ln -sf ${PN}-sit.bin-${MACHINE}-${type}-${PV}-${PR} ${PN}-sit.bin-${MACHINE}-${type}
                        ln -sf ${PN}-sit.bin-${MACHINE}-${type}-${PV}-${PR} sit-${MACHINE}-${type}.bin
                        ln -sf ${PN}-sit.bin-${MACHINE}-${type}-${PV}-${PR} ${PN}-sit.bin-${type}
                    fi
                fi
            done
            unset type_idx
        done
        unset machine_idx
    else
        install -D -m 644 ${B}/.config ${DEPLOYDIR}/${PN}-config-${MACHINE}-${PV}-${PR}
        cd ${DEPLOYDIR}
        ln -sf ${PN}-config-${MACHINE}-${PV}-${PR} ${PN}-config-${MACHINE}
        ln -sf ${PN}-config-${MACHINE}-${PV}-${PR} ${PN}-config
        if [ -f ${B}/sit.bin ]; then
            install -D -m 644 ${B}/sit.bin ${DEPLOYDIR}/${PN}-sit.bin-${MACHINE}-${PV}-${PR}
            cd ${DEPLOYDIR}
            ln -sf ${PN}-sit.bin-${MACHINE}-${PV}-${PR} ${PN}-sit.bin-${MACHINE}
            ln -sf ${PN}-sit.bin-${MACHINE}-${PV}-${PR} sit-${MACHINE}.bin
            ln -sf ${PN}-sit.bin-${MACHINE}-${PV}-${PR} ${PN}-sit.bin
        fi
    fi
}
