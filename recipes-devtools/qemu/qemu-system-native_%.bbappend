FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " \
    file://riscv-use-virtio-blk-device-for-virt-alias.patch \
"
