DESCRIPTION = "Linux microPlatform OSTree initramfs image"

PACKAGE_INSTALL = "initramfs-framework-base \
	initramfs-module-udev \
	initramfs-module-rootfs \
	initramfs-module-ostree \
	initramfs-module-ostree-factory-reset \
	${VIRTUAL-RUNTIME_base-utils} \
	${@bb.utils.contains('DISTRO_FEATURES', 'ima', 'initramfs-framework-ima', '', d)} \
	${@bb.utils.contains('DISTRO_FEATURES', 'luks', '${PACKAGE_INSTALL_LUKS}', '', d)} \
	udev base-passwd e2fsprogs-e2fsck \
	${ROOTFS_BOOTSTRAP_INSTALL}"

# Prefer TPM 2.0 when both are available as OP-TEE requires RPMB/eMMC
PACKAGE_INSTALL_LUKS ?= "\
	${@bb.utils.contains('MACHINE_FEATURES', 'tpm2', 'initramfs-module-cryptfs-tpm2', \
		bb.utils.contains('MACHINE_FEATURES', 'optee', 'initramfs-module-cryptfs-pkcs11', '', d), d)} \
"

SYSTEMD_DEFAULT_TARGET = "initrd.target"

# Do not pollute the initrd image with rootfs features
IMAGE_FEATURES = ""

export IMAGE_BASENAME = "initramfs-ostree-lmp-image"
IMAGE_LINGUAS = ""

LICENSE = "MIT"

IMAGE_FSTYPES = "${INITRAMFS_FSTYPES}"

# avoid circular dependencies
EXTRA_IMAGEDEPENDS = ""

inherit core-image nopackages

IMAGE_ROOTFS_SIZE = "8192"

# Users will often ask for extra space in their rootfs by setting this
# globally.  Since this is a initramfs, we don't want to make it bigger
IMAGE_ROOTFS_EXTRA_SPACE = "0"
IMAGE_OVERHEAD_FACTOR = "1.0"

BAD_RECOMMENDATIONS += "busybox-syslog"

python () {
    initramfs_fstypes = d.getVar('INITRAMFS_FSTYPES')
    image_fstypes = d.getVar('IMAGE_FSTYPES')
    if image_fstypes != initramfs_fstypes:
        bb.fatal('IMAGE_FSTYPES="%s" is not equal to INITRAMFS_FSTYPES="%s"' % (image_fstypes, initramfs_fstypes))
}
