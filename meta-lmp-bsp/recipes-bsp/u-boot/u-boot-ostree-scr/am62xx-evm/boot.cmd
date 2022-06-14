fatload mmc ${mmcdev}:1 ${scriptaddr} /uEnv.txt
env import -t ${scriptaddr} ${filesize}
run bootcmd
