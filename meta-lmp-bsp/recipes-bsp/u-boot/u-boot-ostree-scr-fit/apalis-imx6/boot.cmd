# Default to ixora-v1.1, which is the carrier board we officially support
## Careful when changing to another dtb as the mmcblk order might differ
setenv fdt_file imx6q-apalis-ixora-v1.1.dtb
echo "Using ${fdt_file_r}"

# Default boot type and device
setenv bootlimit 3
setenv devtype mmc
setenv devnum 0
setenv bootpart 1
setenv rootpart 2

setenv fdt_addr 0x15800000
setenv optee_ovl_addr 0x16000000

@@INCLUDE_COMMON@@
