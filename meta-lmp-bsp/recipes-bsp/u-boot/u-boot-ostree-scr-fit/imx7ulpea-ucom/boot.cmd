setenv fdt_file imx7ulpea-ucom-kit_v2.dtb
echo "Using ${fdt_file}"

setenv fdt_file_final ${fdt_file}

# Default boot type and device
setenv bootlimit 3
setenv devtype mmc
setenv devnum 0
setenv bootpart 1
setenv rootpart 2

# Boot image files
setenv optee_ovl_addr 0x65000000
setenv fit_addr ${initrd_addr}
setenv loadaddr ${fit_addr}

# Boot firmware updates
setenv bootloader 2
setenv bootloader2 180
setenv bootloader_s 1002
setenv bootloader2_s 1180
setenv bootloader_image "SPL"
setenv bootloader_s_image ${bootloader_image}
setenv bootloader2_image "u-boot.itb"
setenv bootloader2_s_image ${bootloader2_image}
setenv uboot_hwpart 1

@@INCLUDE_COMMON_IMX@@
@@INCLUDE_COMMON@@
