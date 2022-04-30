DEPENDS += "${@bb.utils.contains('SOTA_EXTRA_CLIENT_FEATURES', 'fiovb', 'optee-fiovb', '' , d)}"

FIOVB_UUID = "22250a54-0bf1-48fe-8002-7b20f1c9c9b1"

EXTRA_OEMAKE += " \
    ${@bb.utils.contains('SOTA_EXTRA_CLIENT_FEATURES', 'fiovb', \
    'CFG_EARLY_TA=y EARLY_TA_PATHS="${STAGING_DIR_TARGET}${nonarch_base_libdir}/optee_armtz/${FIOVB_UUID}.stripped.elf"', \
    '', d)} \
"
