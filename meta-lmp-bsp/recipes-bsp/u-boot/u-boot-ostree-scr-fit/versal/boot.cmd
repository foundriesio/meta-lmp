# Default boot type and device
setenv devtype mmc
setenv devnum ${bootseq}
setenv loadaddr 0x10000000
setenv fdt_file system-top.dtb

ext4load ${devtype} ${devnum}:2 ${loadaddr} /boot/loader/uEnv.txt
env import -t ${loadaddr} ${filesize}

ext4load ${devtype} ${devnum}:2 ${loadaddr} "/boot"${kernel_image}

bootm ${loadaddr}#conf-${fdt_file}
