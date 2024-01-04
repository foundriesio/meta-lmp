PACKAGES += "ostree-recovery-initramfs"
ALLOW_EMPTY:ostree-recovery-initramfs = "1"
FILES:ostree-recovery-initramfs = "${nonarch_base_libdir}/ostree-boot"

INHIBIT_DEFAULT_DEPS = "1"

do_install:append() {
    ostreeboot=${D}${nonarch_base_libdir}/ostree-boot
    install -d $ostreeboot

    if [ -n "${INITRAMFS_RECOVERY_IMAGE}" ]; then
        if [ "${KERNEL_IMAGETYPE}" = "fitImage" ]; then
            cp ${DEPLOY_DIR_IMAGE}/fitImage-${INITRAMFS_RECOVERY_IMAGE}-${MACHINE}-${KERNEL_FIT_LINK_NAME} $ostreeboot/recovery.img
        else
            cp ${DEPLOY_DIR_IMAGE}/${INITRAMFS_RECOVERY_IMAGE}-${MACHINE}.${INITRAMFS_FSTYPES} $ostreeboot/recovery.img
        fi
    fi
}

INITRAMFS_RECOVERY_IMAGE ?= ""
do_install[depends] += "virtual/kernel:do_deploy ${@['${INITRAMFS_RECOVERY_IMAGE}:do_image_complete', ''][d.getVar('INITRAMFS_RECOVERY_IMAGE') == '']}"
