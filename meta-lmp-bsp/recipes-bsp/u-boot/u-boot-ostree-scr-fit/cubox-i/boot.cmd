# Default boot type and device
setenv devtype mmc
setenv devnum ${mmcdev}

load ${devtype} ${devnum}:2 ${loadaddr} /boot/loader/uEnv.txt
env import -t ${loadaddr} ${filesize}

load ${devtype} ${devnum}:2 ${loadaddr} "/boot"${kernel_image}

# Apply OP-TEE overlay (provided by the OP-TEE OS)
imxtract ${loadaddr}#conf@${fdtfile} fdt@${fdtfile} ${fdt_addr}
fdt addr ${fdt_addr}
fdt resize 0x1000
# TODO: OP-TEE overlay available at a build-time known address
# fdt apply 0x18200000

bootm ${loadaddr}#conf@${fdtfile} ${loadaddr}:ramdisk@1 ${fdt_addr}
