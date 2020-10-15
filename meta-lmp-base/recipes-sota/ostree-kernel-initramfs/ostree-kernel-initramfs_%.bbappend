# Ostree workaround to avoid init= in kernel cmdline
do_install_append() {
    if [ "${KERNEL_IMAGETYPE}" = "fitImage" ]; then
        if [ -n "${INITRAMFS_IMAGE}" ]; then
            # this is a hack for ostree not to override init= in kernel cmdline -
            # make it think that the initramfs is present (while it is in FIT image)
            touch $kerneldir/initramfs.img
        fi
    fi
}
