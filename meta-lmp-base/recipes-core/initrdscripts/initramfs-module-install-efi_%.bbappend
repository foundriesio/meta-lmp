FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# Prefer gptfdisk instead of parted
RDEPENDS:${PN}:remove = "parted dosfstools"
RDEPENDS:${PN} += "efibootmgr gptfdisk systemd-crypt efivar"

do_configure:append() {
    if [ "${OSTREE_OTA_EXT4_LUKS}" = "1" ]; then
        if [ -z "${OSTREE_OTA_EXT4_LUKS_PASSPHRASE}" ]; then
	   bbfatal "Unable to find passphrase for LUKS-based ota-ext4 (define OSTREE_OTA_EXT4_LUKS_PASSPHRASE)"
	fi
        file="${S}/init-install-efi.sh"
        watermark="fiopassphrase"
        passphrase="${OSTREE_OTA_EXT4_LUKS_PASSPHRASE}"
        sed -i "s|${watermark}|${passphrase}|g" "$file"
    fi
}
