FILESEXTRAPATHS_prepend := "${THISDIR}/cboot:"

SRC_URI += " \
    file://0001-ext2-fix-symlink-support-in-ext2_dir_lookup.patch \
    file://0001-extlinux-add-support-for-syslinux-ostree.patch \
"
