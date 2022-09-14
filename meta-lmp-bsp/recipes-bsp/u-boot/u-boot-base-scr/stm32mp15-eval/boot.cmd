ext4load mmc 1:2 ${loadaddr} /uEnv.txt
env import -t ${loadaddr} ${filesize}
run bootcmd
