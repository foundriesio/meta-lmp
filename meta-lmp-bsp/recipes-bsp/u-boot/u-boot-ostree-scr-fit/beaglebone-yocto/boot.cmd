# Default boot type and device
setenv bootlimit 3

setenv bootcmd_load_f 'ext4load ${devtype} ${devnum}:2 ${addr_fit} "/boot"${kernel_image}'
setenv bootcmd_run 'bootm ${addr_fit}#conf@${fdtfile}'
setenv bootcmd_rollbackenv 'setenv kernel_image ${kernel_image2}; setenv bootargs ${bootargs2}'
setenv bootcmd_set_rollback 'if test ! "${rollback}" = "1"; then setenv rollback 1; setenv upgrade_available 0; saveenv; fi'
setenv bootostree 'run bootcmd_load_f; run bootcmd_run'
setenv altbootcmd 'run bootcmd_set_rollback; if test -n "${kernel_image2}"; then run bootcmd_rollbackenv; fi; run bootostree; reset'

# Mmc device used for environment needs to be in sync with u-boot config
if test ! -e mmc 0:1 uboot.env; then saveenv; fi

# Reset ostree related vars (for rollback)
setenv kernel_image
setenv bootargs
setenv kernel_image2
setenv bootargs2

ext4load ${devtype} ${devnum}:2 ${loadaddr} /boot/loader/uEnv.txt
env import -t ${loadaddr} ${filesize}

if test "${rollback}" = "1"; then run altbootcmd; else run bootostree; if test ! "${upgrade_available}" = "1"; then setenv upgrade_available 1; saveenv; fi; reset; fi

reset
