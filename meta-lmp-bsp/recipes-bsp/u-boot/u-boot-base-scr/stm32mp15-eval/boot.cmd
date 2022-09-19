ext4load mmc 1:2 ${loadaddr} /boot/uEnv.txt
env import -t ${loadaddr} ${filesize}
run bootcmd
