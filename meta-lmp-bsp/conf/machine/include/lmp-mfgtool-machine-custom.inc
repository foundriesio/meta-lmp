# iMX6UL
UBOOT_SIGN_ENABLE:mx6ul-generic-bsp = "1"
PREFERRED_PROVIDER_virtual/kernel:mx6ul-nxp-bsp = "linux-lmp-dev-mfgtool"
IMX_DEFAULT_BOOTLOADER:mx6ul-generic-bsp ?= "u-boot-fio-mfgtool"
PREFERRED_PROVIDER_u-boot-default-script:mx6ul-generic-bsp = "u-boot-ostree-scr-fit"
UBOOT_CLASSES:mx6ul-generic-bsp = "uboot-fitimage"
IMAGE_BOOT_FILES:remove:mx6ul-generic-bsp = "boot.scr uEnv.txt zImage"
IMAGE_BOOT_FILES:append:mx6ul-generic-bsp = " boot.itb SPL u-boot.itb"
KERNEL_IMAGETYPE:mx6ul-generic-bsp = "fitImage"
KERNEL_CLASSES:mx6ul-generic-bsp = " kernel-lmp-fitimage "
PREFERRED_VERSION_u-boot-fio-mfgtool:mx6ul-nxp-bsp ?= "imx-2023.04"

# iMX6ULL
UBOOT_SIGN_ENABLE:mx6ull-generic-bsp = "1"
PREFERRED_PROVIDER_virtual/kernel:mx6ull-nxp-bsp = "linux-lmp-dev-mfgtool"
IMX_DEFAULT_BOOTLOADER:mx6ull-generic-bsp ?= "u-boot-fio-mfgtool"
PREFERRED_PROVIDER_u-boot-default-script:mx6ull-generic-bsp = "u-boot-ostree-scr-fit"
UBOOT_CLASSES:mx6ull-generic-bsp = "uboot-fitimage"
IMAGE_BOOT_FILES:remove:mx6ull-generic-bsp = "boot.scr uEnv.txt zImage"
IMAGE_BOOT_FILES:append:mx6ull-generic-bsp = " boot.itb SPL u-boot.itb"
KERNEL_IMAGETYPE:mx6ull-generic-bsp = "fitImage"
KERNEL_CLASSES:mx6ull-generic-bsp = " kernel-lmp-fitimage "
PREFERRED_VERSION_u-boot-fio-mfgtool:mx6ull-generic-bsp ?= "imx-2023.04"

# iMX8MQ
UBOOT_SIGN_ENABLE:mx8mq-generic-bsp = "1"
PREFERRED_PROVIDER_virtual/kernel:mx8mq-nxp-bsp = "linux-lmp-dev-mfgtool"
IMX_DEFAULT_BOOTLOADER:mx8mq-generic-bsp ?= "u-boot-fio-mfgtool"
PREFERRED_PROVIDER_u-boot-default-script:mx8mq-generic-bsp = "u-boot-ostree-scr-fit"
IMAGE_BOOT_FILES:mx8mq-nxp-bsp  = "imx-boot u-boot.itb boot.itb"
KERNEL_IMAGETYPE:mx8mq-generic-bsp = "fitImage"
KERNEL_CLASSES:mx8mq-generic-bsp = " kernel-lmp-fitimage "
PREFERRED_VERSION_u-boot-fio-mfgtool:mx8mq-nxp-bsp ?= "imx-2023.04"

# iMX8MPEVK
UBOOT_SIGN_ENABLE:mx8mp-generic-bsp = "1"
IMX_DEFAULT_BOOTLOADER:mx8mp-generic-bsp ?= "u-boot-fio-mfgtool"
PREFERRED_PROVIDER_u-boot-default-script:mx8mp-generic-bsp = "u-boot-ostree-scr"
IMAGE_BOOT_FILES:mx8mp-nxp-bsp  = "imx-boot u-boot.itb boot.itb"
KERNEL_IMAGETYPE:mx8mp-generic-bsp = "fitImage"
KERNEL_CLASSES:mx8mp-generic-bsp = " kernel-lmp-fitimage "
IMXBOOT_TARGETS:imx8mp-lpddr4-evk = "flash_evk"
PREFERRED_VERSION_u-boot-fio-mfgtool:mx8mp-nxp-bsp ?= "imx-2023.04"

# iMX8MM
UBOOT_SIGN_ENABLE:mx8mm-generic-bsp = "1"
IMX_DEFAULT_BOOTLOADER:mx8mm-generic-bsp ?= "u-boot-fio-mfgtool"
PREFERRED_PROVIDER_u-boot-default-script:mx8mm-generic-bsp = "u-boot-ostree-scr"
IMAGE_BOOT_FILES:mx8mm-nxp-bsp  = "imx-boot u-boot.itb boot.itb"
KERNEL_IMAGETYPE:mx8mm-generic-bsp = "fitImage"
KERNEL_CLASSES:mx8mm-generic-bsp = " kernel-lmp-fitimage "
PREFERRED_VERSION_u-boot-fio-mfgtool:mx8mm-nxp-bsp ?= "imx-2023.04"

# iMX8MN
UBOOT_SIGN_ENABLE:mx8mn-generic-bsp = "1"
IMX_DEFAULT_BOOTLOADER:mx8mn-generic-bsp ?= "u-boot-fio-mfgtool"
PREFERRED_PROVIDER_u-boot-default-script:mx8mn-generic-bsp = "u-boot-ostree-scr"
IMAGE_BOOT_FILES:mx8mn-nxp-bsp  = "imx-boot u-boot.itb boot.itb"
KERNEL_IMAGETYPE:mx8mn-generic-bsp = "fitImage"
KERNEL_CLASSES:mx8mn-generic-bsp = " kernel-lmp-fitimage "
IMXBOOT_TARGETS:imx8mn-ddr4-evk = "flash_ddr4_evk"
IMXBOOT_TARGETS:imx8mn-lpddr4-evk = "flash_evk"
PREFERRED_VERSION_u-boot-fio-mfgtool:mx8mn-nxp-bsp ?= "imx-2023.04"

# iMX93
UBOOT_SIGN_ENABLE:mx93-generic-bsp = "1"
IMX_DEFAULT_BOOTLOADER:mx93-generic-bsp ?= "u-boot-fio-mfgtool"
PREFERRED_PROVIDER_u-boot-default-script:mx93-generic-bsp = "u-boot-ostree-scr"
IMAGE_BOOT_FILES:mx93-nxp-bsp  = "imx-boot u-boot.itb boot.itb"
KERNEL_IMAGETYPE:mx93-generic-bsp = "fitImage"
KERNEL_CLASSES:mx93-generic-bsp = " kernel-lmp-fitimage "
IMXBOOT_TARGETS:mx93-nxp-bsp = "flash_singleboot"
PREFERRED_VERSION_u-boot-fio-mfgtool:mx93-generic-bsp ?= "imx-2023.04"

# iMX8QM
IMX_DEFAULT_BOOTLOADER:mx8qm-generic-bsp ?= "u-boot-fio-mfgtool"
PREFERRED_PROVIDER_u-boot-default-script:mx8qm-generic-bsp = "u-boot-ostree-scr-fit"
KERNEL_IMAGETYPE:mx8qm-generic-bsp = "fitImage"
KERNEL_CLASSES:mx8qm-generic-bsp = " kernel-lmp-fitimage "
UBOOT_SIGN_ENABLE:mx8qm-generic-bsp = "1"
UBOOT_CLASSES:mx8qm-generic-bsp = "uboot-fitimage"
IMAGE_BOOT_FILES:mx8qm-nxp-bsp  = "imx-boot u-boot.itb boot.itb"
PREFERRED_VERSION_u-boot-fio-mfgtool:mx8qm-nxp-bsp ?= "imx-2023.04"

# TI Generic (BSP)
INITRAMFS_IMAGE:k3 = "initramfs-ostree-lmp-recovery"
EXTRA_IMAGEDEPENDS:remove:k3 = "u-boot-default-script"
PREFERRED_PROVIDER_virtual/optee-os:k3 = "optee-os-fio-mfgtool"
KERNEL_IMAGETYPE:k3 = "fitImage"
KERNEL_CLASSES:k3 = " kernel-lmp-fitimage "
# TI AM62XX EVM
UBOOT_CONFIG_FRAGMENTS:am62xx-evm-k3r5 = "am62x_r5_usbdfu.config"

# Cross machines / BSPs
PREFERRED_VERSION_u-boot-fio-mfgtool:imx-nxp-bsp ?= "imx-2022.04"
