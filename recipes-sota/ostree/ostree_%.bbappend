FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://update-default-grub-cfg-header.patch \
"

PACKAGECONFIG_append = " curl libarchive"
PACKAGECONFIG_class-native_append = " curl"

EXTRA_OECONF += " \
    --with-builtin-grub2-mkconfig \
"

FILES_${PN} += " \
    ${libdir}/ostree/ostree-grub-generator \
"
