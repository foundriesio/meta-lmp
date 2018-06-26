FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " \
    file://0001-IOTMBL-438-Fix-optee_test-adbg_run.c-strncpy-Werror-.patch \
    file://0001-IOTMBL-438-Fix-optee_test-error-memmove-Werror-array.patch \
"
