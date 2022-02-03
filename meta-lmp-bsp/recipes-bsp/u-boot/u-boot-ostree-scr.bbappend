FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# On kria we need the default provider (fit-based) + scr for compatibility with
# the standard boot firmware, so drop provides to avoid multiple providers
PROVIDES_remove_kv260 = "u-boot-default-script"
