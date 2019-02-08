FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_libc-musl_aarch64 = " file://musl-fixes-armv8.patch"
