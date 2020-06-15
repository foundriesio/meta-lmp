fatload mmc ${mmcdev}:1 ${loadaddr} /uEnv.txt
env import -t ${loadaddr} ${filesize}
run bootcmd
