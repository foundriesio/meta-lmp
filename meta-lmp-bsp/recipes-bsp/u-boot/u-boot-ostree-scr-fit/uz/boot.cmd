# set default fdt_file
setenv fdt_file system-top.dtb
echo "Using ${fdt_file}"

# Default boot type and device
setenv bootlimit 3
setenv devtype mmc
setenv devnum ${bootseq}
setenv bootpart 1
setenv rootpart 2

setenv loadaddr 0x10000000
setenv fdt_addr 0x40000000
setenv optee_ovl_addr 0x22000000
setenv fdt_file_final ${fdt_file}
setenv fit_addr ${ramdisk_addr_r}

setenv bootloader_image "boot.bin"
setenv bootloader_s_image ${bootloader_image}
setenv bootloader2_image "u-boot.itb"
setenv bootloader2_s_image ${bootloader2_image}

setenv check_board_closed "is_boot_authenticated"
setenv check_secondary_boot "multi_boot"

if test "${modeboot}" = "qspiboot"; then
	# Use SD for open boards, and eMMC for closed
	run check_board_closed

	if test -n "${board_is_closed}"; then
		# Use eMMC for further loading/booting Linux FIT image
		setenv devnum 0
	else
		# Use SD for further loading/booting Linux FIT image
		setenv devnum 1
	fi

	setenv qspi_bootloader_offset 0x0
	setenv qspi_bootloader_s_offset 0x60000

	setenv qspi_bootloader2_offset 0x100000
	setenv qspi_bootloader2_s_offset 0xaa0000

	setenv setup_update 'sf probe && setenv update_cmd "sf update ${loadaddr}"'

	# Boot images (primary and secondary)
	setenv bootloader_image_update '${qspi_bootloader_offset}'
	setenv bootloader_s_image_update '${qspi_bootloader_s_offset}'

	# FIT image (primary and secondary)
	setenv bootloader2_image_update '${qspi_bootloader2_offset}'
	setenv bootloader2_s_image_update '${qspi_bootloader2_s_offset}'

	setenv set_primary_boot "multi_boot 0"
	setenv set_secondary_boot "multi_boot 12"

else
	setenv setup_update 'setenv update_cmd "mmc dev ${devnum} && fatwrite mmc ${devnum}:${bootpart} ${loadaddr}"'

	# Boot images (primary and secondary)
	setenv bootloader_image_update 'boot0001.bin'
	setenv bootloader_s_image_update 'boot0002.bin'

	# FIT image (primary and secondary)
	setenv bootloader2_image_update 'u-boot0001.itb'
	setenv bootloader2_s_image_update 'u-boot0002.itb'

	setenv set_primary_boot "multi_boot 1"
	setenv set_secondary_boot "multi_boot 2"
fi

# Writing images
run setup_update
setenv update_primary_image 'echo "${fio_msg} writing ${image_path} ..."; setenv run_update "${update_cmd} ${bootloader_image_update} ${filesize}"; run run_update'
setenv update_secondary_image 'echo "${fio_msg} writing ${image_path} ..."; setenv run_update "${update_cmd} ${bootloader_s_image_update} ${filesize}"; run run_update'
setenv update_primary_image2 'echo "${fio_msg} writing ${image_path} ..."; setenv run_update "${update_cmd} ${bootloader2_image_update} ${filesize}"; run run_update'
setenv update_secondary_image2 'echo "${fio_msg} writing ${image_path} ..."; setenv run_update "${update_cmd} ${bootloader2_s_image_update} ${filesize}"; run run_update'

@@INCLUDE_COMMON@@
