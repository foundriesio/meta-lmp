# iMX6ULL
PREFERRED_PROVIDER_virtual/kernel_mx6ull = "linux-lmp-dev-mfgtool"
PREFERRED_PROVIDER_virtual/bootloader_mx6ull = "u-boot-fio-mfgtool"
PREFERRED_PROVIDER_u-boot_mx6ull = "u-boot-fio-mfgtool"
PREFERRED_PROVIDER_u-boot-default-script_mx6ull = "u-boot-ostree-scr-fit"
IMAGE_BOOT_FILES_remove_mx6ull = "boot.scr uEnv.txt zImage"
IMAGE_BOOT_FILES_append_mx6ull = " boot.itb SPL u-boot.itb"
