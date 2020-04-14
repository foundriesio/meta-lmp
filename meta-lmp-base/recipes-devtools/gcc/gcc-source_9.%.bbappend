FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " \
    file://0001-Define-MUSL_DYNAMIC_LINKER-based-on-SYSTEMLIBS_DIR.patch \
"
