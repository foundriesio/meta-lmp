require optee-os-fio-bsp.inc

OPTEE_SUFFIX:stm32mp1common    = "bin"
OPTEE_HEADER:stm32mp1common    = "tee-header_v2"
OPTEE_PAGEABLE:stm32mp1common  = "tee-pageable_v2"
OPTEE_PAGER:stm32mp1common     = "tee-pager_v2"

do_deploy:append:stm32mp1common() {
    if [ -n "${OPTEE_CONF}" ]; then
        for conf in ${OPTEE_CONF}; do
            install -m 644 ${B}/core/${OPTEE_HEADER}.${OPTEE_SUFFIX} ${DEPLOYDIR}/optee/${OPTEE_HEADER}-${conf}.${OPTEE_SUFFIX}
            install -m 644 ${B}/core/${OPTEE_PAGER}.${OPTEE_SUFFIX} ${DEPLOYDIR}/optee/${OPTEE_PAGER}-${conf}.${OPTEE_SUFFIX}
            install -m 644 ${B}/core/${OPTEE_PAGEABLE}.${OPTEE_SUFFIX} ${DEPLOYDIR}/optee/${OPTEE_PAGEABLE}-${conf}.${OPTEE_SUFFIX}
        done
    fi
}
