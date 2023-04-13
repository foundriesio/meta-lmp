echo "Using freescale_${fdtfile}"

# Default boot type and device
setenv bootlimit 3
setenv devtype mmc
setenv devnum 0
setenv bootpart 1
setenv rootpart 2

# Boot image files
setenv fdt_file_final freescale_${fdtfile}
setenv fit_addr ${initrd_addr}

# Boot firmware updates

# Offsets are in blocks (512KB each)
setenv bootloader 0x0
setenv bootloader2 0x300
setenv bootloader_s ${bootloader}
setenv bootloader2_s ${bootloader2}
setenv bootloader_image "imx-boot"
setenv bootloader_s_image ${bootloader_image}
setenv bootloader2_image "u-boot.itb"
setenv bootloader2_s_image ${bootloader2_image}

setenv update_image_boot0 'echo "${fio_msg} writing ${image_path} ..."; run set_blkcnt && mmc dev ${devnum} 1 && mmc write ${loadaddr} ${start_blk} ${blkcnt}'

setenv backup_primary_image 'echo "${fio_msg} backing up primary boot image set ..."; mmc dev ${devnum} 1 && mmc read ${loadaddr} 0x0 0x2000 && mmc dev ${devnum} 2 && mmc write ${loadaddr} 0x0 0x2000'
setenv restore_primary_image 'echo "${fio_msg} restore primary boot image set ..."; mmc dev ${devnum} 2 && mmc read ${loadaddr} 0x0 0x2000 && mmc dev ${devnum} 1 && mmc write ${loadaddr} 0x0 0x2000'

setenv update_primary_image1 'if test "${ostree_deploy_usr}" = "1"; then setenv image_path "${bootdir}/${bootloader_s_image}"; else setenv image_path "${ostree_root}/usr/lib/firmware/${bootloader_s_image}"; fi; setenv start_blk "${bootloader_s}";  run load_image; run update_image_boot0'
setenv update_primary_image2 'if test "${ostree_deploy_usr}" = "1"; then setenv image_path "${bootdir}/${bootloader2_s_image}"; else setenv image_path "${ostree_root}/usr/lib/firmware/${bootloader2_s_image}"; fi; setenv start_blk "${bootloader2_s}";  run load_image; run update_image_boot0'

setenv update_primary_image 'run update_primary_image1; run update_primary_image2'

setenv do_reboot "reset"

@@INCLUDE_COMMON_IMX@@
@@INCLUDE_COMMON_ALTERNATIVE@@
