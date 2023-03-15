FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI:append:k3 = " \
    file://0001-configs-arm64-k3-am625-sk-Add-crypto-memory-region.patch \
    file://0002-configs-arm64-k3-am625-sk-Switch-inmate-boot-console.patch \
    file://0003-configs-arm64-k3-am625-sk-add-vtm-memory-node.patch \
    file://0004-configs-arm64-k3-am625-sk-Add-GPMC-memory-region.patch \
    file://0001-configs-k3-use-intx-for-bar_mask.patch \
"

COMPATIBLE_MACHINE = "(ti-soc)"
