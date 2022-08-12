FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
	file://cryptfs_pkcs11 \
	file://cryptfs_tpm2 \
	file://ostree \
	file://ostree_factory_reset \
	file://ostree_recovery \
	file://run-tmpfs.patch \
"

PACKAGES:append = " \
	initramfs-module-cryptfs-pkcs11 \
	initramfs-module-cryptfs-tpm2 \
	initramfs-module-ostree \
	initramfs-module-ostree-factory-reset \
	initramfs-module-ostree-recovery \
"

SUMMARY:initramfs-module-cryptfs-pkcs11 = "initramfs support for encrypted filesystems with support for pkcs11"
RDEPENDS:initramfs-module-cryptfs-pkcs11 = "${PN}-base libgcc e2fsprogs-resize2fs e2fsprogs-e2fsck \
					    e2fsprogs-dumpe2fs systemd-crypt opensc openssl-bin libp11 \
					    ${@bb.utils.contains('MACHINE_FEATURES', 'optee', 'optee-client virtual-optee-os-ta', '', d)}"
FILES:initramfs-module-cryptfs-pkcs11 = "/init.d/80-cryptfs_pkcs11"

SUMMARY:initramfs-module-cryptfs-tpm2 = "initramfs support for encrypted filesystems with support for tpm 2.0"
RDEPENDS:initramfs-module-cryptfs-tpm2 = "${PN}-base libgcc e2fsprogs-resize2fs e2fsprogs-e2fsck \
					  e2fsprogs-dumpe2fs systemd-crypt libtss2 libtss2-mu libtss2-tcti-device"
FILES:initramfs-module-cryptfs-tpm2 = "/init.d/80-cryptfs_tpm2"

SUMMARY:initramfs-module-ostree = "initramfs support for ostree based filesystems"
RDEPENDS:initramfs-module-ostree = "${PN}-base ostree-switchroot"
FILES:initramfs-module-ostree = "/init.d/98-ostree"

SUMMARY:initramfs-module-ostree-factory-reset = "initramfs support for ostree based filesystems"
RDEPENDS:initramfs-module-ostree-factory-reset = "${PN}-base ostree-switchroot"
FILES:initramfs-module-ostree-factory-reset = "/init.d/98-ostree_factory_reset"

SUMMARY:initramfs-module-ostree-recovery = "recovery initramfs for ostree based filesystems"
RDEPENDS:initramfs-module-ostree-recovery = "${PN}-base ostree"
FILES:initramfs-module-ostree-recovery = "/init.d/98-ostree_recovery /recovery.d"

do_install:append() {
	install -d ${D}/recovery.d
	install -m 0755 ${WORKDIR}/cryptfs_pkcs11 ${D}/init.d/80-cryptfs_pkcs11
	install -m 0755 ${WORKDIR}/cryptfs_tpm2 ${D}/init.d/80-cryptfs_tpm2
	install -m 0755 ${WORKDIR}/ostree ${D}/init.d/98-ostree
	install -m 0755 ${WORKDIR}/ostree_factory_reset ${D}/init.d/98-ostree_factory_reset
	install -m 0755 ${WORKDIR}/ostree_recovery ${D}/init.d/98-ostree_recovery
}
