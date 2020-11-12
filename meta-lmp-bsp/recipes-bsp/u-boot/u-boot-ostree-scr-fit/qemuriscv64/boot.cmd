# Default boot type and device
setenv bootlimit 3
setenv devtype virtio
setenv devnum 0

setenv bootcmd_load_f 'ext4load ${devtype} ${devnum}:2 ${ramdisk_addr_r} "/boot"${kernel_image}'
setenv bootcmd_run 'bootm ${ramdisk_addr_r}#conf@ ${ramdisk_addr_r}#conf@ ${fdt_addr_r}'
setenv bootcmd_rollbackenv 'setenv kernel_image ${kernel_image2}; setenv bootargs ${bootargs2}'
setenv bootcmd_set_rollback 'if test ! "${rollback}" = "1"; then setenv rollback 1; setenv upgrade_available 0; saveenv; fi'
setenv bootostree 'run bootcmd_load_f; run bootcmd_run'
setenv altbootcmd 'run bootcmd_set_rollback; if test -n "${kernel_image2}"; then run bootcmd_rollbackenv; fi; run bootostree; reset'

if test ! -e ${devtype} ${devnum}:1 uboot.env; then saveenv; fi

# Reset ostree related vars (for rollback)
setenv kernel_image
setenv bootargs
setenv kernel_image2
setenv bootargs2

# Recent kernel commit in 5.3:
# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/arch/riscv/kernel?h=v5.3&id=671f9a3e2e24cdeb2d2856abee7422f093e23e29
# changed page table setup which now crushes the qemu loaded DTB.
# Let's copy the DTB to the established load addr instead where it's safe.
cp ${fdtcontroladdr} ${fdt_addr_r} 1000

ext4load ${devtype} ${devnum}:2 ${scriptaddr} /boot/loader/uEnv.txt
env import -t ${scriptaddr} ${filesize}

if test "${rollback}" = "1"; then run altbootcmd; else run bootostree; if test ! "${upgrade_available}" = "1"; then setenv upgrade_available 1; saveenv; fi; reset; fi

reset
