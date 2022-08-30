fatload mmc 0:6 ${loadaddr} /uEnv.txt
env import -t ${loadaddr} ${filesize}
run bootcmd
