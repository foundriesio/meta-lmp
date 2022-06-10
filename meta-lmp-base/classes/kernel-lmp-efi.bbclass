inherit kernel-artifact-names

# Simple kernel image signing (no unified kernel image)
do_efi_sign() {
	if [ "${UEFI_SIGN_ENABLE}" = "1" ]; then
		if [ ! -f "${UEFI_SIGN_KEYDIR}/DB.key" -o ! -f "${UEFI_SIGN_KEYDIR}/DB.crt" ]; then
			bbfatal "UEFI_SIGN_KEYDIR or DB.key/crt is invalid"
		fi

		for imageType in ${KERNEL_IMAGETYPES}; do
			if [ -s ${B}/${KERNEL_OUTPUT_DIR}/$imageType.stripped ]; then
				kernel=${B}/${KERNEL_OUTPUT_DIR}/$imageType.stripped
			else
				kernel=${B}/${KERNEL_OUTPUT_DIR}/$imageType
			fi
			sbsign --key ${UEFI_SIGN_KEYDIR}/DB.key --cert ${UEFI_SIGN_KEYDIR}/DB.crt $kernel
			sbverify --cert ${UEFI_SIGN_KEYDIR}/DB.crt $kernel.signed
			mv $kernel.signed $kernel
		done
	fi
}
do_efi_sign[depends] += "sbsigntool-native:do_populate_sysroot"
do_efi_sign[vardeps] += "UEFI_SIGN_ENABLE UEFI_SIGN_KEYDIR"
addtask efi_sign before do_deploy after do_bundle_initramfs
