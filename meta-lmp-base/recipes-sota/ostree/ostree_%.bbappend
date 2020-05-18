FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Disable PTEST for ostree as it requires options that are not enabled when
# building with meta-updater and meta-lmp.
PTEST_ENABLED = "0"

SRC_URI += " \
    file://update-default-grub-cfg-header.patch \
"
