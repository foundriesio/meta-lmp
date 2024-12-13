# Default boot type and device
setenv bootlimit 3
setenv devtype virtio
setenv devnum 0

# Remove optee core reserved memory entry as secure-memory is already defined by QEMU
setenv bootcmd_updfdt 'fdt addr ${fdt_addr}; fdt rm /reserved-memory/optee_core@0xe100000'
setenv bootcmd_resetvars 'setenv kernel_image; setenv bootdir; setenv bootargs; setenv kernel_image2; setenv bootdir2; setenv bootargs2'
setenv bootcmd_otenv 'run bootcmd_resetvars; ext4load ${devtype} ${devnum}:2 ${scriptaddr} /boot/loader/uEnv.txt; env import -t ${scriptaddr} ${filesize} kernel_image bootdir bootargs kernel_image2 bootdir2 bootargs2'
setenv bootcmd_load_f 'ext4load ${devtype} ${devnum}:2 ${ramdisk_addr_r} ${kernel_image}'
setenv bootcmd_load_r 'ext4load ${devtype} ${devnum}:2 ${ramdisk_addr_r} ${bootdir}/recovery.img'
setenv bootcmd_run 'bootm ${ramdisk_addr_r}#conf-1 ${ramdisk_addr_r}#conf-1 ${fdt_addr}'
setenv bootcmd_rollbackenv 'setenv kernel_image ${kernel_image2}; setenv bootdir ${bootdir2}; setenv bootargs ${bootargs2}'
setenv bootcmd_set_rollback 'if test ! "${rollback}" = "1"; then setenv rollback 1; setenv upgrade_available 0; saveenv; fi'
setenv bootostree 'if test "${recovery}" = "1"; then run bootcmd_load_r; setenv recovery; saveenv; else run bootcmd_load_f; fi; run bootcmd_run'
setenv altbootcmd 'run bootcmd_otenv; run bootcmd_set_rollback; if test -n "${kernel_image2}"; then run bootcmd_rollbackenv; fi; run bootcmd_updfdt; run bootostree; reset'

if test ! -e ${devtype} ${devnum}:1 uboot.env; then saveenv; fi

if test "${rollback}" = "1"; then run altbootcmd; else run bootcmd_otenv; run bootcmd_updfdt; run bootostree; if test ! "${upgrade_available}" = "1"; then setenv upgrade_available 1; saveenv; fi; reset; fi

reset
