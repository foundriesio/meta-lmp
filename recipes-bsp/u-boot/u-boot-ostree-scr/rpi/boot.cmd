setenv kernel_addr_load 0x01000000
setenv kernel_addr_r 0x03100000
fatload mmc 0:1 $loadaddr /uEnv.txt
env import -t $loadaddr $filesize
run bootcmd
