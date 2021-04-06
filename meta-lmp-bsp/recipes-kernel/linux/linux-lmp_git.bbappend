FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_corstone700 = " \
    file://defconfig \
"

# fix OP-TEE performance regression for Cortex-A9 i.MX6QDL
SRC_URI_append_apalis-imx6 = " \
    file://0001-MLK-16912-PL310-unlock-ways-during-initialization.patch \
"

# Modules are not supported on corstone700, so allow empty
# package to satisfy rdependencies.
PACKAGES_append_corstone700 = " kernel-module-wireguard"
ALLOW_EMPTY_kernel-module-wireguard_corstone700 = "1"
