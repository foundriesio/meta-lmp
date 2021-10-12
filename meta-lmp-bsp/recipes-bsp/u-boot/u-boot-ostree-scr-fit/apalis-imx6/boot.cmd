# Default to ixora-v1.1, which is the carrier board we officially support
## Careful when changing to another dtb as the mmcblk order might differ
setenv fdt_file_final imx6q-apalis-ixora-v1.1.dtb
echo "Using ${fdt_file_final}"

# Default boot type and device
setenv bootlimit 3
setenv devtype mmc
setenv devnum 0
setenv bootpart 1
setenv rootpart 2

setenv fdt_addr 0x15800000
setenv optee_ovl_addr 0x16000000
setenv fit_addr ${loadaddr}

# Boot firmware updates
setenv bootloader 2
setenv bootloader2 100
setenv bootloader_s 802
setenv bootloader2_s 900
setenv bootloader_image "SPL"
setenv bootloader_s_image ${bootloader_image}
setenv bootloader2_image "u-boot.itb"
setenv bootloader2_s_image ${bootloader2_image}
setenv uboot_hwpart 1

@@INCLUDE_COMMON_IMX@@
@@INCLUDE_COMMON@@
