FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://update-default-grub-cfg-header.patch \
    file://avoid-race-condition-tests-build.patch \
    file://grub2-add-support-for-devicetree.patch \
"
