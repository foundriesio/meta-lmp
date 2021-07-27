## iMX targets should use the u-boot release based on the NXP BSP
PREFERRED_VERSION_u-boot-fio-mfgtool_imx ?= "2020.04"

# Embedded Artists i.MX7ULP COM
UBOOT_SIGN_ENABLE_imx7ulpea-ucom = "1"
PREFERRED_PROVIDER_virtual/kernel_imx7ulpea-ucom = "linux-lmp-dev-mfgtool"
KERNEL_REPO_imx7ulpea-ucom ?= "git://github.com/foundriesio/linux.git"
LINUX_VERSION_imx7ulpea-ucom ?= "5.4.y"
KERNEL_BRANCH_imx7ulpea-ucom ?= "linux-ea-v5.4.y"
PREFERRED_PROVIDER_virtual/bootloader_imx7ulpea-ucom = "u-boot-fio-mfgtool"
PREFERRED_PROVIDER_u-boot_imx7ulpea-ucom = "u-boot-fio-mfgtool"
PREFERRED_PROVIDER_u-boot-default-script_imx7ulpea-ucom = "u-boot-ostree-scr-fit"
UBOOT_CLASSES_imx7ulpea-ucom = "uboot-fitimage"
IMAGE_BOOT_FILES_imx7ulpea-ucom = "boot.itb SPL u-boot.itb"
KERNEL_IMAGETYPE_imx7ulpea-ucom = "fitImage"
KERNEL_CLASSES_imx7ulpea-ucom = " kernel-lmp-fitimage "

# iMX6ULL
UBOOT_SIGN_ENABLE_mx6ull = "1"
PREFERRED_PROVIDER_virtual/kernel_mx6ull = "linux-lmp-dev-mfgtool"
KERNEL_REPO_mx6ull ?= "git://source.codeaurora.org/external/imx/linux-imx.git"
LINUX_VERSION_mx6ull ?= "5.4.y"
KERNEL_BRANCH_mx6ull ?= "imx_5.4.24_2.1.0"
IMX_DEFAULT_BOOTLOADER_mx6ull ?= "u-boot-fio-mfgtool"
PREFERRED_PROVIDER_u-boot-default-script_mx6ull = "u-boot-ostree-scr-fit"
UBOOT_CLASSES_mx6ull = "uboot-fitimage"
IMAGE_BOOT_FILES_remove_mx6ull = "boot.scr uEnv.txt zImage"
IMAGE_BOOT_FILES_append_mx6ull = " boot.itb SPL u-boot.itb"
KERNEL_IMAGETYPE_mx6ull = "fitImage"
KERNEL_CLASSES_mx6ull = " kernel-lmp-fitimage "

# iMX8MQ
UBOOT_SIGN_ENABLE_mx8mq = "1"
PREFERRED_PROVIDER_virtual/kernel_mx8mq = "linux-lmp-dev-mfgtool"
IMX_DEFAULT_BOOTLOADER_mx8mq ?= "u-boot-fio-mfgtool"
PREFERRED_PROVIDER_u-boot-default-script_mx8mq = "u-boot-ostree-scr-fit"
IMAGE_BOOT_FILES_mx8mq  = "imx-boot u-boot.itb boot.itb"
KERNEL_IMAGETYPE_mx8mq = "fitImage"
KERNEL_CLASSES_mx8mq = " kernel-lmp-fitimage "

# iMX8MM
UBOOT_SIGN_ENABLE_mx8mm = "1"
IMX_DEFAULT_BOOTLOADER_mx8mm ?= "u-boot-fio-mfgtool"
PREFERRED_PROVIDER_u-boot-default-script_mx8mm = "u-boot-ostree-scr"
IMAGE_BOOT_FILES_mx8mm  = "imx-boot u-boot.itb boot.itb"
KERNEL_IMAGETYPE_mx8mm = "fitImage"
KERNEL_CLASSES_mx8mm = " kernel-lmp-fitimage "

# Apalis-iMX6
UBOOT_SIGN_ENABLE_apalis-imx6 = "1"
PREFERRED_PROVIDER_virtual/kernel_apalis-imx6 = "linux-lmp-dev-mfgtool"
KERNEL_REPO_apalis-imx6 ?= "git://github.com/foundriesio/linux.git"
LINUX_VERSION_apalis-imx6 ?= "5.4.y"
KERNEL_BRANCH_apalis-imx6 ?= "linux-v5.4.y"
IMX_DEFAULT_BOOTLOADER_apalis-imx6 ?= "u-boot-fio-mfgtool"
PREFERRED_PROVIDER_u-boot-default-script_apalis-imx6 = "u-boot-ostree-scr-fit"
UBOOT_CLASSES_apalis-imx6 = "uboot-fitimage"
IMAGE_BOOT_FILES_apalis-imx6 = "boot.itb SPL u-boot.itb"
KERNEL_IMAGETYPE_apalis-imx6 = "fitImage"
KERNEL_CLASSES_apalis-imx6 = " kernel-lmp-fitimage "

# iMX8QM-MEK and Apalis-iMX8
IMX_DEFAULT_BOOTLOADER_mx8qm ?= "u-boot-fio-mfgtool"
PREFERRED_PROVIDER_u-boot-default-script_mx8qm = "u-boot-ostree-scr-fit"
KERNEL_IMAGETYPE_mx8qm = "fitImage"
KERNEL_CLASSES_mx8qm = " kernel-lmp-fitimage "
