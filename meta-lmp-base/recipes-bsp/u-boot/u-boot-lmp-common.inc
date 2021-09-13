# Common include for all LMP u-boot recipes

# Also deploy u-boot config used during build
do_deploy_append() {
    if [ -n "${UBOOT_CONFIG}" ]; then
        for config in ${UBOOT_MACHINE}; do
            i=$(expr $i + 1);
            for type in ${UBOOT_CONFIG}; do
                j=$(expr $j + 1);
                if [ $j -eq $i ]; then
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
            unset j
        done
        unset i
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
