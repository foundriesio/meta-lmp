fatload mmc 0:5 ${loadaddr} /uEnv.txt
env import -t ${loadaddr} ${filesize}
run bootcmd
