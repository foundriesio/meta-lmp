OPTEE_SUFFIX:stm32mp1common    = "bin"
OPTEE_HEADER:stm32mp1common    = "tee-header_v2"
OPTEE_PAGEABLE:stm32mp1common  = "tee-pageable_v2"
OPTEE_PAGER:stm32mp1common     = "tee-pager_v2"

# TI HS signing logic (from meta-ti-bsp optee-os bbappend)
do_compile:prepend:k3() {
    export TI_SECURE_DEV_PKG=${TI_SECURE_DEV_PKG}
}
# Signing procedure for K3 HS devices
optee_sign_k3hs() {
    ( cd ${B}/core/; \
        if [ -f ${TI_SECURE_DEV_PKG}/scripts/secure-binary-image.sh ]; then \
            ${TI_SECURE_DEV_PKG}/scripts/secure-binary-image.sh tee-pager_v2.bin tee-pager_v2.bin.signed; \
        else \
            echo "Warning: TI_SECURE_DEV_PKG not set, OP-TEE not signed."; \
            cp tee-pager_v2.bin tee-pager_v2.bin.signed; \
        fi; \
    )
}
do_compile:append:k3() {
    optee_sign_k3hs
}
do_install:append:k3() {
    install -m 644 ${B}/core/tee-pager_v2.bin.signed ${D}${nonarch_base_libdir}/firmware/
}

do_deploy:append:stm32mp1common() {
    if [ -n "${OPTEE_CONF}" ]; then
        for conf in ${OPTEE_CONF}; do
            install -m 644 ${B}/core/${OPTEE_HEADER}.${OPTEE_SUFFIX} ${DEPLOYDIR}/optee/${OPTEE_HEADER}-${conf}.${OPTEE_SUFFIX}
            install -m 644 ${B}/core/${OPTEE_PAGER}.${OPTEE_SUFFIX} ${DEPLOYDIR}/optee/${OPTEE_PAGER}-${conf}.${OPTEE_SUFFIX}
            install -m 644 ${B}/core/${OPTEE_PAGEABLE}.${OPTEE_SUFFIX} ${DEPLOYDIR}/optee/${OPTEE_PAGEABLE}-${conf}.${OPTEE_SUFFIX}
        done
    fi
}
