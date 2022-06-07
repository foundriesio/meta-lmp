# Ostree handles the default boot configuration
RDEPENDS:${PN}:remove:sota = "virtual-systemd-bootconf"

# Install systemd-boot at expected path for tools such as bootctl
do_install:append() {
	install -d ${D}${nonarch_base_libdir}/systemd/boot/efi
	install ${B}/src/boot/efi/systemd-boot*.efi ${D}${nonarch_base_libdir}/systemd/boot/efi
}

FILES:${PN} += "${nonarch_base_libdir}/systemd/boot/efi"
