fatload ${devtype} ${devnum}:1 ${loadaddr} /uEnv-lmp.txt
env import -t ${loadaddr} ${filesize}
run bootcmd
