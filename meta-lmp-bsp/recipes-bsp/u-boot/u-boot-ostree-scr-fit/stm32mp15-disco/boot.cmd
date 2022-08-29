echo "Using ${fdtfile}"

# Default boot type and device
setenv bootlimit 3
setenv devtype ${boot_device}
setenv devnum ${boot_instance}
setenv bootpart 5
setenv rootpart 6
setenv fit_addr ${ramdisk_addr_r}
setenv fdt_file_final ${fdtfile}
setenv fdt_addr ${fdt_addr_r}

setenv loadaddr ${ramdisk_addr_r}
setenv do_reboot "reset"
setenv check_board_closed 'if test "${boot_auth}" = "2"; then setenv board_is_closed 1; else setenv board_is_closed; fi;'
setenv check_secondary_boot 'if test "${boot_part}" = "2"; then setenv fiovb.is_secondary_boot 1; else setenv fiovb.is_secondary_boot 0; fi;'

# All values are provided in blocks (512 bytes each)
setenv bootloader 0x22
setenv bootloader_s 0x222
setenv bootloader2 0x422
setenv bootloader2_s 0x2422
setenv bootloader_size 0x200 # FSBL image is 256 Kb
setenv bootloader2_size 0x2000 # FIP image is 4 Mb
setenv bootloader_ostree "tf-a-stm32mp157c-dk2-sdcard.stm32"
setenv bootloader2_ostree "fip-stm32mp157c-dk2-optee.bin"
setenv uboot_hwpart 0

setenv backup_primary_image 'echo "${fio_msg} backing up primary boot image set ..."; mmc dev ${devnum} ${uboot_hwpart} && mmc read ${loadaddr} ${bootloader} ${bootloader_size} && mmc write ${loadaddr} ${bootloader_s} ${bootloader_size} && mmc read ${loadaddr} ${bootloader2} ${bootloader2_size} && mmc write ${loadaddr} ${bootloader2_s} ${bootloader2_size}'
setenv restore_primary_image 'echo "${fio_msg} restore primary boot image set ..."; mmc dev ${devnum} ${uboot_hwpart} && mmc read ${loadaddr} ${bootloader_s} ${bootloader_size} && mmc write ${loadaddr} ${bootloader} ${bootloader_size} && mmc read ${loadaddr} ${bootloader2_s} ${bootloader2_size} && mmc write ${loadaddr} ${bootloader2} ${bootloader2_size}'

setenv update_image 'echo "${fio_msg} writing ${image_path} ..."; run set_blkcnt && mmc dev ${devnum} ${uboot_hwpart} && mmc write ${loadaddr} ${start_blk} ${blkcnt}'
setenv update_primary_image1 'setenv image_path "${ostree_root}/usr/lib/firmware/${bootloader_ostree}"; setenv start_blk "${bootloader}"; run load_image; run update_image'
setenv update_primary_image2 'setenv image_path "${ostree_root}/usr/lib/firmware/${bootloader2_ostree}"; setenv start_blk "${bootloader2}"; run load_image; run update_image'
setenv update_primary_image 'run update_primary_image1 && run update_primary_image2'

@@INCLUDE_COMMON_ALTERNATIVE@@
