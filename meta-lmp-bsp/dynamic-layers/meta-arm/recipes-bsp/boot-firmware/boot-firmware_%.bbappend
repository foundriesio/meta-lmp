FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_corstone700 = " \
    file://0001-Increase-firewall-size-for-kernel.patch \
    file://0002-Support-both-gzip-and-xip-rootfs-types.patch \
"
