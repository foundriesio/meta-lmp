FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI_append_toradex = " \
    file://0001-Revert-Add-NXP-s-SoCs-partition-reboot-support.patch \
"
