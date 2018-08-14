FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://update-default-grub-cfg-header.patch \
    file://avoid-race-condition-tests-build.patch \
"
