echo "Using freescale_${fdt_file}"

# Default boot type and device
setenv bootlimit 3
setenv devtype mmc
setenv devnum 2
setenv bootpart 1
setenv rootpart 2

setenv fdt_file_final freescale_${fdt_file}
setenv fit_addr ${initrd_addr}

@@INCLUDE_COMMON@@
