fatload mmc 0:3 ${scriptaddr} /uEnv.txt
env import -t ${scriptaddr} ${filesize}
run bootcmd
