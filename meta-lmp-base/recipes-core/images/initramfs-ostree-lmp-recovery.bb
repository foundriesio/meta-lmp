DESCRIPTION = "Linux microPlatform OSTree initramfs recovery image"

inherit core-image nopackages

PACKAGE_INSTALL = " \
	aktualizr-lite \
	base-files \
	base-passwd \
	busybox \
	e2fsprogs-e2fsck \
	e2fsprogs-mke2fs \
	e2fsprogs-resize2fs \
	initramfs-framework-base \
	initramfs-module-ostree-recovery \
	initramfs-module-udev \
	ostree \
	udev \
	util-linux-mount \
	${@bb.utils.contains('MACHINE_FEATURES', 'fiovb', 'optee-fiovb', '' , d)} \
	${@bb.utils.contains('SOTA_CLIENT_FEATURES', 'ubootenv', 'u-boot-fw-utils', '' , d)} \
	${ROOTFS_BOOTSTRAP_INSTALL}"


# Do not pollute the initrd image with rootfs features
IMAGE_FEATURES = ""
IMAGE_LINGUAS = ""

export IMAGE_BASENAME = "initramfs-ostree-lmp-recovery"

LICENSE = "MIT"

IMAGE_FSTYPES = "cpio.gz"
IMAGE_FSTYPES:remove = "wic wic.gz wic.bmap wic.nopt ext4 ext4.gz"
IMAGE_CLASSES:remove = "image_repo_manifest"

# avoid circular dependencies
EXTRA_IMAGEDEPENDS = ""

IMAGE_ROOTFS_SIZE = "8192"

# Users will often ask for extra space in their rootfs by setting this
# globally.  Since this is a initramfs, we don't want to make it bigger
IMAGE_ROOTFS_EXTRA_SPACE = "0"
IMAGE_OVERHEAD_FACTOR = "1.0"

# No need to automatically mount the rootfs
BAD_RECOMMENDATIONS += " \
	initramfs-module-rootfs \
"
