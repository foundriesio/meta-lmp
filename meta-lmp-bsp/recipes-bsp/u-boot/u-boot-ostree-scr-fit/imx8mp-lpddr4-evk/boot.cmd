echo "Using freescale_${fdtfile}"

# Default boot type and device
setenv bootlimit 3
setenv devtype mmc
setenv devnum 2
setenv bootpart 1
setenv rootpart 2

# Boot image files
setenv fdt_file_final freescale_${fdtfile}
setenv fit_addr 0x43800000

# Boot firmware updates

# Offsets are in blocks (512 bytes each)
setenv bootloader 0x0
setenv bootloader2 0x300
setenv bootloader_s 0x1000
setenv bootloader2_s 0x1300

setenv bootloader_image "imx-boot"
setenv bootloader_s_image ${bootloader_image}
setenv bootloader2_image "u-boot.itb"
setenv bootloader2_s_image ${bootloader2_image}
setenv uboot_hwpart 1

@@INCLUDE_COMMON_IMX@@
@@INCLUDE_COMMON@@
