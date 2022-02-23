# iMX6ULL
PREFERRED_PROVIDER_virtual/kernel_mx6ull = "linux-lmp-dev-mfgtool"
PREFERRED_PROVIDER_virtual/bootloader_mx6ull = "u-boot-fio-mfgtool"
PREFERRED_PROVIDER_u-boot_mx6ull = "u-boot-fio-mfgtool"
PREFERRED_PROVIDER_u-boot-default-script_mx6ull = "u-boot-ostree-scr-fit"
IMAGE_BOOT_FILES_remove_mx6ull = "boot.scr uEnv.txt zImage"
IMAGE_BOOT_FILES_append_mx6ull = " boot.itb SPL u-boot.itb"

# iMX6UL / iMX6ULL
PREFERRED_PROVIDER_virtual/kernel_mx6ul = "linux-lmp-dev-mfgtool"
PREFERRED_PROVIDER_virtual/bootloader_mx6ul = "u-boot-fio-mfgtool"
PREFERRED_PROVIDER_u-boot_mx6ul = "u-boot-fio-mfgtool"
PREFERRED_PROVIDER_u-boot-default-script_mx6ul = "u-boot-ostree-scr-fit"
IMAGE_BOOT_FILES_remove_mx6ul = "boot.scr uEnv.txt zImage"
IMAGE_BOOT_FILES_append_mx6ul = " boot.itb SPL u-boot.itb"

# NXP iMX6UL EVK
UBOOT_SIGN_ENABLE_imx6ulevk = "1"
PREFERRED_VERSION_u-boot-fio-mfgtool_imx6ulevk = "2020.04"
KERNEL_REPO_imx6ulevk = "git://github.com/Freescale/linux-fslc.git"
PREFERRED_VERSION_optee-os-fio-mfgtool_imx6ulevk = "3.15.0+git"
PREFERRED_VERSION_optee-client_imx6ulevk = "3.15.0"
PREFERRED_VERSION_optee-examples_imx6ulevk = "3.15.0"
PREFERRED_VERSION_optee-test_imx6ulevk = "3.15.0"
