require efitools.inc

DEPENDS += "gnu-efi-native"

inherit native

EXTRA_OEMAKE += " \
    INCDIR_PREFIX='${STAGING_DIR_NATIVE}' \
    CRTPATH_PREFIX='${STAGING_DIR_NATIVE}' \
"
