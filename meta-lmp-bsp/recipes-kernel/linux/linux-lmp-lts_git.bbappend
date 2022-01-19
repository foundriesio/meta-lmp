FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:corstone700 = " \
    file://defconfig \
"

# Modules are not supported on corstone700, so allow empty
# package to satisfy rdependencies.
PACKAGES:append:corstone700 = " kernel-module-wireguard"
ALLOW_EMPTY:kernel-module-wireguard:corstone700 = "1"
