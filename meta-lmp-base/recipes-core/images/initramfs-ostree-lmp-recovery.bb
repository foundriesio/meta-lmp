DESCRIPTION = "Linux microPlatform OSTree initramfs recovery image"

inherit core-image nopackages

SRC_URI = "\
	file://uboot_env.sh \
	file://udhcpc.sh \
	file://image_download.sh \
"

PACKAGE_INSTALL = " \
	base-files \
	base-passwd \
	busybox \
	e2fsprogs-e2fsck \
	e2fsprogs-mke2fs \
	e2fsprogs-resize2fs \
	initramfs-framework-base \
	initramfs-module-debug \
	initramfs-module-ostree-recovery \
	initramfs-module-udev \
	os-release \
	udev \
	util-linux-mount \
	${@bb.utils.contains('MACHINE_FEATURES', 'fiovb', 'optee-fiovb', '' , d)} \
	${@bb.utils.contains('SOTA_CLIENT_FEATURES', 'ubootenv', 'u-boot-default-env u-boot-fw-utils', '' , d)} \
	${ROOTFS_BOOTSTRAP_INSTALL}"


IMAGE_NAME_SUFFIX = ""
# Do not pollute the initrd image with rootfs features
IMAGE_FEATURES = ""
IMAGE_LINGUAS = ""

export IMAGE_BASENAME = "initramfs-ostree-lmp-recovery"

LICENSE = "MIT"

IMAGE_FSTYPES = "cpio.gz"
IMAGE_FSTYPES:remove = "wic wic.gz wic.bmap wic.img wic.nopt ext4 ext4.gz aioflash.tar"
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

addtask rootfs after do_unpack

python () {
    d.delVarFlag("do_fetch", "noexec")
    d.delVarFlag("do_unpack", "noexec")
}

fakeroot do_populate_recovery_rootfs () {
	if ${@bb.utils.contains('SOTA_CLIENT_FEATURES', 'ubootenv', 'true', 'false', d)}; then
		install -m 0755 ${WORKDIR}/uboot_env.sh ${IMAGE_ROOTFS}/recovery.d/10-uboot_env
	fi
	install -m 0755 ${WORKDIR}/udhcpc.sh ${IMAGE_ROOTFS}/recovery.d/20-udhcpc
	install -m 0755 ${WORKDIR}/image_download.sh ${IMAGE_ROOTFS}/recovery.d/30-image_download
}

IMAGE_PREPROCESS_COMMAND += "do_populate_recovery_rootfs; "
