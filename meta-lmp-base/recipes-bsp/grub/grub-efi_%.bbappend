RDEPENDS:${PN}:class-target:remove:sota = "virtual/grub-bootconf"

GRUB_BUILDIN += "reboot"

# Create startup.nsh so it can be consumed by wic
do_deploy:append:class-target_intel-corei7-64() {
	DEST_IMAGE=$(echo ${GRUB_IMAGE} | sed -e 's/^grub-efi-//')
	echo 'fs0:\\EFI\\BOOT\\'${DEST_IMAGE} > startup.nsh
	install -m 755 ${B}/startup.nsh ${DEPLOYDIR}
}
