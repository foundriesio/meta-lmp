FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://update-default-grub-cfg-header.patch \
    file://grub2-add-support-for-devicetree.patch \
"

SRC_URI_append_libc-musl = " \
    file://musl-fixes.patch \
"
