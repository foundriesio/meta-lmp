# set default fdt_file
run findfdt
echo "Using ${fdt_file}"

# Default boot type and device
setenv bootlimit 3
setenv devtype mmc
setenv devnum ${mmcdev}
setenv bootpart 1
setenv rootpart 2

setenv fdt_addr 85800000
setenv optee_ovl_addr 0x86000000

@@INCLUDE_COMMON@@
