# Default boot type and device
setenv bootcmd_envinit 'setenv bootlimit 3; setenv devtype virtio; setenv devnum 0'
setenv bootcmd_load_f 'ext4load ${devtype} ${devnum}:2 ${ramdisk_addr_r} "/boot"${kernel_image}'
setenv bootcmd_run 'bootm ${ramdisk_addr_r}#conf@ ${ramdisk_addr_r}#conf@ ${fdt_addr}'
setenv bootcmd_rollbackenv 'setenv kernel_image ${kernel_image2}; setenv bootargs ${bootargs2}'
setenv bootcmd_otenv 'ext4load ${devtype} ${devnum}:2 ${loadaddr} /boot/loader/uEnv.txt; env import -t ${scriptaddr} ${filesize};'
setenv bootcmd_set_rollback 'if test ! "${rollback}" = "1"; then env default -a; run bootcmd_envinit; run bootcmd_otenv; setenv rollback 1; setenv upgrade_available 0; saveenv; fi'
setenv bootostree 'run bootcmd_load_f; run bootcmd_run'
setenv altbootcmd 'run bootcmd_set_rollback; if test -n "${kernel_image2}"; then run bootcmd_rollbackenv; fi; run bootostree; reset'

if test ! -e ${devtype} ${devnum}:1 uboot.env; then saveenv; fi

# Reset ostree related vars (for rollback)
setenv kernel_image
setenv bootargs
setenv kernel_image2
setenv bootargs2

# Remove optee core reserved memory entry as secure-memory is already defined by QEMU
fdt addr ${fdt_addr}
fdt rm /reserved-memory/optee_core@0xe100000

run bootcmd_envinit
run bootcmd_otenv

if test "${rollback}" = "1"; then run altbootcmd; else run bootostree; if test ! "${upgrade_available}" = "1"; then setenv upgrade_available 1; saveenv; fi; reset; fi

reset
