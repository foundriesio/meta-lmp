FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

SRC_URI_append = " \
	file://riscv-support.patch;patchdir=../../ \
"
