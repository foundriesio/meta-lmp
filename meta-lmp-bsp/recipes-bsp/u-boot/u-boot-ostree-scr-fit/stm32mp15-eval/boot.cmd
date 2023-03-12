setenv fdtfile stm32mp157c-ev1-scmi.dtb

echo "Using ${fdtfile}"

# Default boot type and device
setenv bootlimit 3
setenv devtype ${boot_device}
setenv devnum ${boot_instance}
setenv rootpart 2
setenv fit_addr ${ramdisk_addr_r}
setenv fdt_file_final ${fdtfile}
setenv fdt_addr ${fdt_addr_r}
setenv optee_ovl_addr 0xc4300000

setenv loadaddr ${ramdisk_addr_r}
setenv do_reboot "reset"
setenv check_board_closed 'if test "${boot_auth}" = "2"; then setenv board_is_closed 1; else setenv board_is_closed; fi;'
setenv check_secondary_boot 'if test "${boot_part}" = "2"; then setenv fiovb.is_secondary_boot 1; else setenv fiovb.is_secondary_boot 0; fi;'

# All values are provided in blocks (512 bytes each)
setenv bootloader 0x0
setenv bootloader2 0x200
setenv bootloader_size 0x1000
setenv bootloader_s ${bootloader}
setenv bootloader2_s ${bootloader2}
setenv bootloader_image "tf-a-stm32mp157c-ev1-emmc.stm32"
setenv bootloader_s_image ${bootloader_image}
setenv bootloader2_image "fip-stm32mp157c-ev1-optee.bin"
setenv bootloader2_s_image ${bootloader2_image}

setenv update_image_boot0 '\
	echo "${fio_msg} writing ${image_path} ..."; \
	run set_blkcnt && \
	mmc dev ${devnum} && \
	mmc partconf ${devnum} 1 1 1 && \
	mmc write ${loadaddr} ${start_blk} ${blkcnt} && \
	mmc partconf ${devnum} 1 1 0 \
'

setenv backup_primary_image '\
	echo "${fio_msg} backing up primary boot image set ..."; \
	mmc dev ${devnum} && \
	mmc partconf ${devnum} 1 1 1 && \
	mmc read ${loadaddr} ${bootloader} ${bootloader_size} && \
	mmc partconf ${devnum} 1 1 0 && \
	mmc dev ${devnum} && \
	mmc partconf ${devnum} 1 1 2 && \
	mmc write ${loadaddr} ${bootloader} ${bootloader_size} && \
	mmc partconf ${devnum} 1 1 0 \
'

setenv restore_primary_image '\
	echo "${fio_msg} restore primary boot image set ..." ; \
	mmc dev ${devnum} && \
	mmc partconf ${devnum} 1 1 2 && \
	mmc read ${loadaddr} ${bootloader} ${bootloader_size} && \
	mmc partconf ${devnum} 1 1 0 && \
	mmc dev ${devnum} && \
	mmc partconf ${devnum} 1 1 1 && \
	mmc write ${loadaddr} ${bootloader} ${bootloader_size} && \
	mmc partconf ${devnum} 1 1 0 \
'

setenv update_primary_image1 'setenv image_path "${ostree_root}/usr/lib/firmware/${bootloader_s_image}"; setenv start_blk "${bootloader_s}";  run load_image; run update_image_boot0'
setenv update_primary_image2 'setenv image_path "${ostree_root}/usr/lib/firmware/${bootloader2_s_image}"; setenv start_blk "${bootloader2_s}";  run load_image; run update_image_boot0'

setenv update_primary_image 'run update_primary_image1 && run update_primary_image2'

@@INCLUDE_COMMON_ALTERNATIVE@@
