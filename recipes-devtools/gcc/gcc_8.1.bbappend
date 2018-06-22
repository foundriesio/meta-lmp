FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " \
	file://riscv-Use-SYSTEMLIBS_DIR-replacement-instead-of-hardcoding.patch \
"
