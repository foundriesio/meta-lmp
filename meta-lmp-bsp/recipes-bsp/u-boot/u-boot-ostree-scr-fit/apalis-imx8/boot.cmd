# Default to ixora-v1.1, which is the carrier board we officially support
setenv fdt_file fsl-imx8qm-apalis-ixora-v1.1.dtb
echo "Using freescale_${fdt_file}"

# Default boot type and device
setenv bootlimit 3
setenv devtype mmc
setenv devnum ${mmcdev}
setenv hdmi_image hdmitxfw.bin
setenv m4_0_image core0_m4_image.bin
setenv m4_1_image core1_m4_image.bin

setenv bootcmd_boot_hdmi 'hdp load ${loadaddr}'
setenv bootcmd_boot_m4_0 'dcache flush; bootaux ${loadaddr} 0'
setenv bootcmd_boot_m4_1 'dcache flush; bootaux ${loadaddr} 1'
setenv bootcmd_load_hdmi 'if imxtract ${ramdisk_addr_r}#conf@freescale_${fdt_file} loadable@${hdmi_image} ${loadaddr}; then run bootcmd_boot_hdmi; fi'
setenv bootcmd_load_m4_0 'if imxtract ${ramdisk_addr_r}#conf@freescale_${fdt_file} loadable@${m4_0_image} ${loadaddr}; then run bootcmd_boot_m4_0; fi;'
setenv bootcmd_load_m4_1 'if imxtract ${ramdisk_addr_r}#conf@freescale_${fdt_file} loadable@${m4_1_image} ${loadaddr}; then run bootcmd_boot_m4_1; fi;'
setenv bootcmd_resetvars 'setenv kernel_image; setenv bootargs; setenv kernel_image2; setenv bootargs2'
setenv bootcmd_otenv 'run bootcmd_resetvars; ext4load ${devtype} ${devnum}:2 ${loadaddr} /boot/loader/uEnv.txt; env import -t ${loadaddr} ${filesize}'
setenv bootcmd_load_f 'ext4load ${devtype} ${devnum}:2 ${ramdisk_addr_r} "/boot"${kernel_image}'
setenv bootcmd_run 'bootm ${ramdisk_addr_r}#conf@freescale_${fdt_file}'
setenv bootcmd_rollbackenv 'setenv kernel_image ${kernel_image2}; setenv bootargs ${bootargs2}'
setenv bootcmd_set_rollback 'if test ! "${rollback}" = "1"; then setenv rollback 1; setenv upgrade_available 0; saveenv; fi'
setenv bootostree 'run bootcmd_load_f; run bootcmd_load_hdmi; run bootcmd_load_m4_0; run bootcmd_load_m4_1; run bootcmd_run'
setenv altbootcmd 'run bootcmd_otenv; run bootcmd_set_rollback; if test -n "${kernel_image2}"; then run bootcmd_rollbackenv; fi; run bootostree; reset'

if test ! -e ${devtype} ${devnum}:1 uboot.env; then saveenv; fi

if test "${rollback}" = "1"; then run altbootcmd; else run bootcmd_otenv; run bootostree; if test ! "${upgrade_available}" = "1"; then setenv upgrade_available 1; saveenv; fi; reset; fi

reset
