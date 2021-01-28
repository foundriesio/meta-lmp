# set default fdt_file
setenv fdt_file system-top.dtb
echo "Using ${fdt_file}"

# Default boot type and device
setenv bootlimit 3
setenv devtype mmc
setenv devnum 0
setenv fpga_image bitstream.bit.bin

setenv loadaddr 0x10000000
setenv fdt_addr 0x1f000000
setenv optee_ovl_addr 0x22000000
setenv fpga_addr 0x18000000

setenv bootcmd_resetvars 'setenv kernel_image; setenv bootargs; setenv kernel_image2; setenv bootargs2'
setenv bootcmd_otenv 'run bootcmd_resetvars; ext4load ${devtype} ${devnum}:2 ${loadaddr} /boot/loader/uEnv.txt; env import -t ${loadaddr} ${filesize}'
setenv bootcmd_load_f 'ext4load ${devtype} ${devnum}:2 ${loadaddr} "/boot"${kernel_image}'
setenv bootcmd_tee_ovy 'imxtract ${loadaddr}#conf@${fdtfile} fdt@${fdt_file} ${fdt_addr}; fdt addr ${fdt_addr}; fdt resize 0x1000; fdt apply ${optee_ovl_addr}'
setenv bootcmd_fpga 'imxtract ${loadaddr}#conf@${fdtfile} loadable@${fpga_image} ${fpga_addr}; fpga load 0 ${fpga_addr} ${filesize}'
setenv bootcmd_run 'bootm ${loadaddr}#conf@${fdt_file} ${loadaddr}#conf@${fdt_file} ${fdt_addr}'
setenv bootcmd_rollbackenv 'setenv kernel_image ${kernel_image2}; setenv bootargs ${bootargs2}'
setenv bootcmd_set_rollback 'if test ! "${rollback}" = "1"; then setenv rollback 1; setenv upgrade_available 0; saveenv; fi'
setenv bootostree 'run bootcmd_load_f; run bootcmd_tee_ovy; run bootcmd_fpga; run bootcmd_run'
setenv altbootcmd 'run bootcmd_otenv; run bootcmd_set_rollback; if test -n "${kernel_image2}"; then run bootcmd_rollbackenv; fi; run bootostree; reset'

if test ! -e ${devtype} ${devnum}:1 uboot.env; then saveenv; fi

if test "${rollback}" = "1"; then run altbootcmd; else run bootcmd_otenv; run bootostree; if test ! "${upgrade_available}" = "1"; then setenv upgrade_available 1; saveenv; fi; reset; fi

reset
