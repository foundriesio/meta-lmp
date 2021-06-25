fatload mmc ${mmcdev}:${mmcpart} ${loadaddr} /uEnv.txt
env import -t ${loadaddr} ${filesize}
run bootcmd
