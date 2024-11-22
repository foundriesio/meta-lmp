FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
	file://cryptfs \
	file://cryptfs_pkcs11 \
	file://cryptfs_tpm2 \
	file://ostree \
	file://ostree_factory_reset \
	file://ostree_recovery \
	file://run-tmpfs.patch \
"

PACKAGES:append = " \
	initramfs-module-cryptfs \
	initramfs-module-cryptfs-pkcs11 \
	initramfs-module-cryptfs-tpm2 \
	initramfs-module-ostree \
	initramfs-module-ostree-factory-reset \
	initramfs-module-ostree-recovery \
"

SUMMARY:initramfs-module-cryptfs = "initramfs support for encrypted filesystems"
RDEPENDS:initramfs-module-cryptfs = "${PN}-base libgcc e2fsprogs-resize2fs e2fsprogs-e2fsck e2fsprogs-dumpe2fs systemd-crypt efivar"
FILES:initramfs-module-cryptfs = "/init.d/80-cryptfs"

SUMMARY:initramfs-module-cryptfs-pkcs11 = "encrypted filesystems with support for pkcs11"
RDEPENDS:initramfs-module-cryptfs-pkcs11 = "initramfs-module-cryptfs opensc openssl-bin libp11 \
					    ${@bb.utils.contains('MACHINE_FEATURES', 'optee', 'optee-client virtual-optee-os-ta', '', d)}"
FILES:initramfs-module-cryptfs-pkcs11 = "${sysconfdir}/cryptfs/pkcs11"

SUMMARY:initramfs-module-cryptfs-tpm2 = "encrypted filesystems with support for tpm 2.0"
RDEPENDS:initramfs-module-cryptfs-tpm2 = "initramfs-module-cryptfs \
					  ${@bb.utils.contains('MACHINE_FEATURES', 'tpm2', 'libtss2 libtss2-mu libtss2-tcti-device', '', d)}"
FILES:initramfs-module-cryptfs-tpm2 = "${sysconfdir}/cryptfs/tpm2"

SUMMARY:initramfs-module-ostree = "initramfs support for ostree based filesystems"
RDEPENDS:initramfs-module-ostree = "${PN}-base ostree-switchroot"
FILES:initramfs-module-ostree = "/init.d/98-ostree"

SUMMARY:initramfs-module-ostree-factory-reset = "initramfs support for ostree based filesystems"
RDEPENDS:initramfs-module-ostree-factory-reset = "${PN}-base ostree-switchroot"
FILES:initramfs-module-ostree-factory-reset = "/init.d/98-ostree_factory_reset"

SUMMARY:initramfs-module-ostree-recovery = "recovery initramfs for ostree based filesystems"
RDEPENDS:initramfs-module-ostree-recovery = "${PN}-base ostree"
FILES:initramfs-module-ostree-recovery = "/init.d/98-ostree_recovery /recovery.d"

do_configure:append() {
    if [ "${OSTREE_OTA_EXT4_LUKS}" = "1" ]; then
        if [ -z "${OSTREE_OTA_EXT4_LUKS_PASSPHRASE}" ]; then
	   bbfatal "Unable to find passphrase for LUKS-based ota-ext4 (define OSTREE_OTA_EXT4_LUKS_PASSPHRASE)"
	fi
        file="${S}/cryptfs"
        watermark="fiopassphrase"
        passphrase="${OSTREE_OTA_EXT4_LUKS_PASSPHRASE}"
        sed -i "s|${watermark}|${passphrase}|g" "$file"
    fi
}

do_install:append() {
	install -d ${D}/recovery.d
	install -d ${D}/${sysconfdir}/cryptfs
	install -m 0644 ${WORKDIR}/cryptfs_pkcs11 ${D}/${sysconfdir}/cryptfs/pkcs11
	install -m 0644 ${WORKDIR}/cryptfs_tpm2 ${D}/${sysconfdir}/cryptfs/tpm2

	install -m 0755 ${WORKDIR}/cryptfs ${D}/init.d/80-cryptfs
	install -m 0755 ${WORKDIR}/ostree ${D}/init.d/98-ostree
	install -m 0755 ${WORKDIR}/ostree_factory_reset ${D}/init.d/98-ostree_factory_reset
	install -m 0755 ${WORKDIR}/ostree_recovery ${D}/init.d/98-ostree_recovery
}
