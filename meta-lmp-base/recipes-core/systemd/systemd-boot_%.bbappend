# Ostree handles the default boot configuration
RDEPENDS:${PN}:remove:sota = "virtual-systemd-bootconf"

# Install systemd-boot at expected path for tools such as bootctl
do_install:append() {
	install -d ${D}${nonarch_base_libdir}/systemd/boot/efi
	install ${B}/src/boot/efi/systemd-boot*.efi ${D}${nonarch_base_libdir}/systemd/boot/efi
}

FILES:${PN} += "${nonarch_base_libdir}/systemd/boot/efi"

do_efi_sign() {
	if [ "${UEFI_SIGN_ENABLE}" = "1" ]; then
		if [ ! -f "${UEFI_SIGN_KEYDIR}/DB.key" -o ! -f "${UEFI_SIGN_KEYDIR}/DB.crt" ]; then
			bbfatal "UEFI_SIGN_KEYDIR or DB.key/crt is invalid"
		fi

		for efi in `find ${B}/src/boot/efi -name '*.efi'`; do
			sbsign --key ${UEFI_SIGN_KEYDIR}/DB.key --cert ${UEFI_SIGN_KEYDIR}/DB.crt $efi
			sbverify --cert ${UEFI_SIGN_KEYDIR}/DB.crt $efi.signed
			mv $efi.signed $efi
		done
	fi
}
do_efi_sign[depends] += "sbsigntool-native:do_populate_sysroot"
do_efi_sign[vardeps] += "UEFI_SIGN_ENABLE UEFI_SIGN_KEYDIR"
addtask efi_sign after do_compile before do_install do_deploy
