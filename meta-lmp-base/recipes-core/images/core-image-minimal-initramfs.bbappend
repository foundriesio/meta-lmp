# Only initramfs-module-install-efi is supported
INITRAMFS_SCRIPTS:remove = "initramfs-module-install"

SSTATE_SKIP_CREATION:task-image-qa = "0"
SSTATE_SKIP_CREATION:task-image-complete = "0"

inherit nopackages
