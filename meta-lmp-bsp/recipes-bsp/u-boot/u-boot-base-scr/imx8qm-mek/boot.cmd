setenv fdt_file imx8qm-mek.dtb
echo "Using freescale_${fdt_file}"

# Default boot type and device
setenv devtype mmc
setenv devnum 0
setenv boot_file Image
setenv bootfile ${boot_file}
setenv kernel_addr_r 0x80280000
setenv mmcroot /dev/mmcblk0p2

fatload ${devtype} ${devnum}:1 ${loadaddr} /uEnv.txt
env import -t ${loadaddr} ${filesize}
run bootcmd
