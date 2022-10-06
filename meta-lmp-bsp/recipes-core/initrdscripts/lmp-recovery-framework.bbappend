FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

RDEPENDS:append:lmp-recovery-module-sample-uboot-env:qemuarm64 = " \
	e2fsprogs-e2fsck \
	e2fsprogs-mke2fs \
	e2fsprogs-resize2fs \
	util-linux-mount"
