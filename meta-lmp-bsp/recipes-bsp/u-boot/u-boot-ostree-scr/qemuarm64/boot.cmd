if test ${distro_bootpart} != 1
then
    echo "Boot partition needs to be the first partition"
    exit
fi

fatload ${devtype} ${devnum}:1 $scriptaddr /uEnv.txt
env import -t $scriptaddr $filesize
run bootcmd
