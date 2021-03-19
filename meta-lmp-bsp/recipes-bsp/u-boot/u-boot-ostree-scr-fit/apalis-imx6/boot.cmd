# Default to ixora-v1.1, which is the carrier board we officially support
## Careful when changing to another dtb as the mmcblk order might differ
setenv fdt_file_r imx6q-apalis-ixora-v1.1.dtb
echo "Using ${fdt_file_r}"

# Default boot type and device
setenv bootlimit 3
setenv devtype mmc
setenv devnum 0

setenv fdt_addr 0x15800000
setenv optee_ovl_addr 0x16000000

setenv bootcmd_resetvars 'setenv kernel_image; setenv bootargs; setenv kernel_image2; setenv bootargs2'
setenv bootcmd_otenv 'run bootcmd_resetvars; ext4load ${devtype} ${devnum}:2 ${loadaddr} /boot/loader/uEnv.txt; env import -t ${loadaddr} ${filesize}'
setenv bootcmd_load_f 'ext4load ${devtype} ${devnum}:2 ${loadaddr} "/boot"${kernel_image}'
setenv bootcmd_tee_ovy 'imxtract ${loadaddr}#conf@@FIT_NODE_SEPARATOR@@${fdt_file_r} fdt@@FIT_NODE_SEPARATOR@@${fdt_file_r} ${fdt_addr}; fdt addr ${fdt_addr}; fdt resize 0x1000; fdt apply ${optee_ovl_addr}'
setenv bootcmd_run 'bootm ${loadaddr}#conf@@FIT_NODE_SEPARATOR@@${fdt_file_r} ${loadaddr}#conf@@FIT_NODE_SEPARATOR@@${fdt_file_r} ${fdt_addr}'
setenv bootcmd_rollbackenv 'setenv kernel_image ${kernel_image2}; setenv bootargs ${bootargs2}'
setenv bootcmd_set_rollback 'if test ! "${rollback}" = "1"; then setenv rollback 1; setenv upgrade_available 0; saveenv; fi'
setenv bootostree 'run bootcmd_load_f; run bootcmd_tee_ovy; run bootcmd_run'
setenv altbootcmd 'run bootcmd_otenv; run bootcmd_set_rollback; if test -n "${kernel_image2}"; then run bootcmd_rollbackenv; fi; run bootostree; reset'

if test ! -e ${devtype} ${devnum}:1 uboot.env; then saveenv; fi

if test "${rollback}" = "1"; then run altbootcmd; else run bootcmd_otenv; run bootostree; if test ! "${upgrade_available}" = "1"; then setenv upgrade_available 1; saveenv; fi; reset; fi

reset
