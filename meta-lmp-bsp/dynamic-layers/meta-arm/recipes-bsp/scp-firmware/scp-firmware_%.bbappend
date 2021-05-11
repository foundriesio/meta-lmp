FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRCREV_corstone700 = "af7eeb1bb8c5a85a5e5a76d48acc6fe864d715a9"

SRC_URI_append_corstone700 = " \
    file://0001-Increase-firewall-size-for-kernel.patch \
    file://0002-Support-both-gzip-and-xip-rootfs-types.patch \
"
