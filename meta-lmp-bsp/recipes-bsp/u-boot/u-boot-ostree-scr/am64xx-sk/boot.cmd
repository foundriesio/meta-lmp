setenv loadaddr 0x90000000
setenv devtype mmc
setenv devnum ${mmcdev}
run findfdt
load ${devtype} ${devnum}:2 ${loadaddr} /boot/loader/uEnv.txt
env import -t ${loadaddr} ${filesize}
load ${devtype} ${devnum}:2 ${loadaddr} ${kernel_image}
bootm ${loadaddr}#conf@ti_${fdtfile}
