FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:sota = " \
	file://0001-L4TLauncher-boot-syslinux-instead-of-extlinux-for-os.patch;patchdir=../edk2-nvidia \
"

do_deploy:append() {
	install -m 0644 ${B}/images/BOOTAA64.efi ${DEPLOYDIR}/
}
