FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_hikey += " \
    file://sota_compatible_grub_config.patch;patchdir=.. \
"

SRC_URI_append_hikey960 += " \
    file://sota_compatible_grub_config.patch;patchdir=.. \
"

RDEPENDS_${PN}_class-target_remove_sota = "virtual/grub-bootconf"

# Create startup.nsh so it can be consumed by wic
do_deploy_append_class-target() {
	DEST_IMAGE=$(echo ${GRUB_IMAGE} | sed -e 's/^grub-efi-//')
	echo 'fs0:\\EFI\\BOOT\\'${DEST_IMAGE} > startup.nsh
	install -m 755 ${B}/startup.nsh ${DEPLOYDIR}
}
