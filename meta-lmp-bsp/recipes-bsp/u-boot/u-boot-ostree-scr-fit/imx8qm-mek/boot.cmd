setenv fdt_file imx8qm-mek.dtb
echo "Using ${fdt_file}"

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
setenv fdt_file_final ${fdt_file}

setenv bootcmd_boot_hdmi 'hdp load ${loadaddr}'
setenv bootcmd_boot_m4_0 'dcache flush; bootaux ${loadaddr} 0'
setenv bootcmd_boot_m4_1 'dcache flush; bootaux ${loadaddr} 1'
setenv bootcmd_load_hdmi 'if imxtract ${ramdisk_addr_r}#conf-${fdt_file} loadable-${hdmi_image} ${loadaddr}; then run bootcmd_boot_hdmi; fi'
setenv bootcmd_load_m4_0 'if imxtract ${ramdisk_addr_r}#conf-${fdt_file} loadable-${m4_0_image} ${loadaddr}; then run bootcmd_boot_m4_0; fi;'
setenv bootcmd_load_m4_1 'if imxtract ${ramdisk_addr_r}#conf-${fdt_file} loadable-${m4_1_image} ${loadaddr}; then run bootcmd_boot_m4_1; fi;'
setenv bootcmd_load_fw 'run bootcmd_load_hdmi; run bootcmd_load_m4_0; run bootcmd_load_m4_1;'

# Boot firmware updates

# Offsets are in blocks (512 bytes each)
setenv bootloader 0x0
setenv bootloader2 0x400
setenv bootloader_s ${bootloader}
setenv bootloader2_s ${bootloader2}
setenv bootloader_image "imx-boot"
setenv bootloader_s_image ${bootloader_image}
setenv bootloader2_image "u-boot.itb"
setenv bootloader2_s_image ${bootloader2_image}

setenv update_image_boot0 'echo "${fio_msg} writing ${image_path} ..."; run set_blkcnt && mmc dev ${devnum} 1 && mmc write ${loadaddr} ${start_blk} ${blkcnt}'

setenv backup_primary_image 'echo "${fio_msg} backing up primary boot image set ..."; mmc dev ${devnum} 1 && mmc read ${loadaddr} 0x0 0x3FFE && mmc dev ${devnum} 2 && mmc write ${loadaddr} 0x0 0x3FFE'
setenv restore_primary_image 'echo "${fio_msg} restore primary boot image set ..."; mmc dev ${devnum} 2 && mmc read ${loadaddr} 0x0 0x3FFE && mmc dev ${devnum} 1 && mmc write ${loadaddr} 0x0 0x3FFE'

setenv update_primary_image1 'if test "${ostree_deploy_usr}" = "1"; then setenv image_path "${bootdir}/${bootloader_s_image}"; else setenv image_path "${ostree_root}/usr/lib/firmware/${bootloader_s_image}"; fi; setenv start_blk "${bootloader_s}";  run load_image; run update_image_boot0'
setenv update_primary_image2 'if test "${ostree_deploy_usr}" = "1"; then setenv image_path "${bootdir}/${bootloader2_s_image}"; else setenv image_path "${ostree_root}/usr/lib/firmware/${bootloader2_s_image}"; fi; setenv start_blk "${bootloader2_s}";  run load_image; run update_image_boot0'

setenv update_primary_image 'run update_primary_image1; run update_primary_image2'

setenv do_reboot "reboot"

@@INCLUDE_COMMON_IMX@@
@@INCLUDE_COMMON_ALTERNATIVE@@
