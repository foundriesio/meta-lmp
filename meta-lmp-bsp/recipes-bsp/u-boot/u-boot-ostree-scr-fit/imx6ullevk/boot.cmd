# set default fdt_file
run findfdt
echo "Using ${fdt_file}"

setenv fdt_file_final ${fdt_file}

# Default boot type and device
setenv bootlimit 3
setenv devtype mmc
setenv devnum ${mmcdev}
setenv bootpart 1
setenv rootpart 2

setenv fdt_addr 85800000
setenv optee_ovl_addr 0x86000000
setenv fit_addr ${loadaddr}

# Boot firmware updates
setenv bootloader 2
setenv bootloader2 8a
setenv bootloader_s 1002
setenv bootloader2_s 108a
setenv bootloader_image "SPL"
setenv bootloader_s_image ${bootloader_image}
setenv bootloader2_image "u-boot.itb"
setenv bootloader2_s_image ${bootloader2_image}
setenv uboot_hwpart 0

@@INCLUDE_COMMON_IMX@@
@@INCLUDE_COMMON@@
