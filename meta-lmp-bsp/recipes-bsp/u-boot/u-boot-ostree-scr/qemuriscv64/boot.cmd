if test ${distro_bootpart} != 1
then
    echo "Boot partition needs to be the first partition"
    exit
fi

# Recent kernel commit in 5.3:
# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/riscv/kernel?h=v5.3&id=671f9a3e2e24cdeb2d2856abee7422f093e23e29
# changed page table setup which now crushes the qemu loaded DTB.
# Let's copy the DTB to the established load addr instead where it's safe.
cp ${fdtcontroladdr} ${fdt_addr_r} 1000

fatload ${devtype} ${devnum}:1 $scriptaddr /uEnv.txt
env import -t $scriptaddr $filesize
run bootcmd
