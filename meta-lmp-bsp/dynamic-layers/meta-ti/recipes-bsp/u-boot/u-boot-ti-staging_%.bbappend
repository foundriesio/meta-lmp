FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_am64xx-sk = " \
    file://0001-am64xx-sk-set-bootm-len-to-64.patch \
"

PACKAGECONFIG[optee] = "TEE=${STAGING_DIR_HOST}${nonarch_base_libdir}/firmware/tee-pager_v2.bin,,optee-os-fio"
