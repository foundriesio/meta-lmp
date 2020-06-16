fatload mmc 1:1 ${loadaddr} /uEnv.txt
env import -t ${loadaddr} ${filesize}
run bootcmd
