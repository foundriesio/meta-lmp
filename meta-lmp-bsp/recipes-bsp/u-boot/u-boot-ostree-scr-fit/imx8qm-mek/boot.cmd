setenv fdt_file imx8qm-mek.dtb
echo "Using freescale_${fdt_file}"

# Default boot type and device
setenv bootlimit 3
setenv devtype mmc
setenv devnum 0
setenv bootpart 1
setenv rootpart 2
setenv hdmi_image hdmitxfw.bin
setenv m4_0_image core0_m4_image.bin
setenv m4_1_image core1_m4_image.bin
setenv ramdisk_addr_r 0x8a000000
# enable relocation of ramdisk
setenv initrd_high

# Boot image files
setenv fit_addr ${ramdisk_addr_r}
setenv fdt_file_final freescale_${fdt_file}

setenv bootcmd_boot_hdmi 'hdp load ${loadaddr}'
setenv bootcmd_boot_m4_0 'dcache flush; bootaux ${loadaddr} 0'
setenv bootcmd_boot_m4_1 'dcache flush; bootaux ${loadaddr} 1'
setenv bootcmd_load_hdmi 'if imxtract ${ramdisk_addr_r}#conf@@FIT_NODE_SEPARATOR@@freescale_${fdt_file} loadable@@FIT_NODE_SEPARATOR@@${hdmi_image} ${loadaddr}; then run bootcmd_boot_hdmi; fi'
setenv bootcmd_load_m4_0 'if imxtract ${ramdisk_addr_r}#conf@@FIT_NODE_SEPARATOR@@freescale_${fdt_file} loadable@@FIT_NODE_SEPARATOR@@${m4_0_image} ${loadaddr}; then run bootcmd_boot_m4_0; fi;'
setenv bootcmd_load_m4_1 'if imxtract ${ramdisk_addr_r}#conf@@FIT_NODE_SEPARATOR@@freescale_${fdt_file} loadable@@FIT_NODE_SEPARATOR@@${m4_1_image} ${loadaddr}; then run bootcmd_boot_m4_1; fi;'
setenv bootcmd_load_fw 'run bootcmd_load_hdmi; run bootcmd_load_m4_0; run bootcmd_load_m4_1;'

# Boot firmware updates
setenv bootloader 0
setenv bootloader2 400
setenv bootloader_s ${bootloader}
setenv bootloader2_s ${bootloader2}
setenv bootloader_image "imx-boot"
setenv bootloader_s_image ${bootloader_image}
setenv bootloader2_image "u-boot.itb"
setenv bootloader2_s_image ${bootloader2_image}

setenv update_image_boot0 'echo "${fio_msg} writing ${image_path} ..."; run set_blkcnt && mmc dev ${devnum} 1 && mmc write ${loadaddr} ${start_blk} ${blkcnt}'
setenv update_image_boot1 'echo "${fio_msg} writing ${image_path} ..."; run set_blkcnt && mmc dev ${devnum} 2 && mmc write ${loadaddr} ${start_blk} ${blkcnt}'

setenv backup_boot0 'echo "${fio_msg} backing up primary boot image set ..."; run set_blkcnt && mmc dev ${devnum} 1 && mmc read ${loadaddr} 0x0 0x3FFE && mmc dev ${devnum} 2 && mmc write ${loadaddr} 0x0 0x3FFE'
setenv restore_boot0 'echo "${fio_msg} restore primary boot image set ..."; run set_blkcnt && mmc dev ${devnum} 2 && mmc read ${loadaddr} 0x0 0x3FFE && mmc dev ${devnum} 1 && mmc write ${loadaddr} 0x0 0x3FFE'

setenv update_primary_image "run update_image_boot0"
setenv update_primary_image2 "run update_image_boot0"

setenv do_reboot "reboot"

@@INCLUDE_COMMON_IMX@@
@@INCLUDE_COMMON_ALTERNATIVE@@
