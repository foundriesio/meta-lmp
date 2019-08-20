# Default boot type and device
setenv devtype mmc
setenv devnum ${mmcdev}

load ${devtype} ${devnum}:2 ${loadaddr} /boot/loader/uEnv.txt
env import -t ${loadaddr} ${filesize}

load ${devtype} ${devnum}:2 ${loadaddr} "/boot"${kernel_image}

bootm ${loadaddr}#conf@${fdtfile}
