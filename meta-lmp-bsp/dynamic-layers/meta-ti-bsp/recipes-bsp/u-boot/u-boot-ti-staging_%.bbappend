FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# From the 08.04.00.005 dunfell tag
SRCREV = "a169f4261024397dd3ddb944decc1601a623df2a"

SRC_URI:append:am64xx-evm = " \
    file://fw_env.config \
    file://lmp.cfg \
"

SRC_URI:append:am62xx-evm = " \
    file://0001-am62xx-evm-set-bootm-len-to-64M.patch \
    file://fw_env.config \
    file://lmp.cfg \
"

PACKAGECONFIG[optee] = "TEE=${STAGING_DIR_HOST}${nonarch_base_libdir}/firmware/tee-pager_v2.bin,,optee-os-fio"
