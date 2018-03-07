FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_sota_hikey += " \
    file://sota_compatible_grub_config.patch;patchdir=.. \
"
