if mmc dev 1; then
    setenv mmcdev 1;
else
    setenv mmcdev 0;
fi
fatload mmc $mmcdev:1 $loadaddr /uEnv.txt
env import -t $loadaddr $filesize
run bootcmd
