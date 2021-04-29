if test ${distro_bootpart} != 1
then
    echo "Boot partition needs to be the first partition"
    exit
fi

fatload ${devtype} ${devnum}:1 ${ramdisk_addr_r} /uEnv.txt
env import -t ${ramdisk_addr_r} ${filesize}
run bootcmd
