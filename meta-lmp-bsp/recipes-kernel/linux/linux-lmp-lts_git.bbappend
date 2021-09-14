FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_corstone700 = " \
    file://defconfig \
"

# Modules are not supported on corstone700, so allow empty
# package to satisfy rdependencies.
PACKAGES_append_corstone700 = " kernel-module-wireguard"
ALLOW_EMPTY_kernel-module-wireguard_corstone700 = "1"
