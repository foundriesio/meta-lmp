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

setenv dtoverlay zynqmp-sck-kv-g-rev${card1_rev}.dtbo
setenv enable_tpm2 'tpm2 init; tpm2 startup TPM2_SU_CLEAR'
setenv bootcmd_custom_run 'run enable_tpm2; bootm ${fit_addr}#conf-system-top.dtb#conf-${dtoverlay}'

setenv bootloader_image "boot.bin"
setenv bootloader_s_image ${bootloader_image}
setenv bootloader2_image "u-boot.itb"
setenv bootloader2_s_image ${bootloader2_image}

setenv check_board_closed "is_boot_authenticated"

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

	# boot.bin
	setenv qspi_bootloader_offset 0x200000
	setenv qspi_bootloader_s_offset 0xF80000

	# u-boot.itb
	setenv qspi_bootloader2_offset 0x300000
	setenv qspi_bootloader2_s_offset 0x1080000

	setenv setup_update 'setenv update_cmd "sf probe; sf update ${loadaddr}"'

	# nop, primary will be booted automatically by image selector
	# after one attempt to boot secondary
	bootslot

	if test "${zynqmp.image_a_bootable}" = "1" && test "${multiboot}" = "40"; then
		# A is considered as primary (stable), B is secondary (experimental)
		setenv set_secondary_boot "multi_boot 0; bootslot 1 0 1"
		setenv set_primary_boot "multi_boot 0; bootslot 1 0 0"
		# Set slot B as primary (stable)
		setenv custom_apply_stable "multi_boot 0; bootslot 1 1 1"

		# Boot images (primary and secondary)
		setenv bootloader_image_update '${qspi_bootloader_offset}'
		setenv bootloader_s_image_update '${qspi_bootloader_s_offset}'

		# FIT image (primary and secondary)
		setenv bootloader2_image_update '${qspi_bootloader2_offset}'
		setenv bootloader2_s_image_update '${qspi_bootloader2_s_offset}'
	fi

	if test "${zynqmp.image_b_bootable}" = "1" && test "${multiboot}" = "1f0"; then
		# B is is considered as primary (stable), A is secondary (experimental)
		setenv set_secondary_boot "multi_boot 0; bootslot 0 1 0"
		setenv set_primary_boot "multi_boot 0; bootslot 0 1 1"
		# Set slot A as primary (stable)
		setenv custom_apply_stable "multi_boot 0; bootslot 1 1 0"

		# Boot images (primary and secondary), swapped
		setenv bootloader_image_update '${qspi_bootloader_s_offset}'
		setenv bootloader_s_image_update '${qspi_bootloader_offset}'

		# FIT image (primary and secondary)
		setenv bootloader2_image_update '${qspi_bootloader2_s_offset}'
		setenv bootloader2_s_image_update '${qspi_bootloader2_offset}'
	fi

	# If slot A (multiboot = 0x40) is booted and marked as not bootable, that means we are booting "secondary" path
	# If slot B (multiboot = 0x1F0) is booted and marked as not bootable, that means we are booting "secondary" path
	# otherwise it's primary
	setenv check_secondary_boot "true"
	if test "${zynqmp.image_a_bootable}" = "0" && test "${multiboot}" = "40"; then
		setenv fiovb.is_secondary_boot "1"
	else
		if test "${zynqmp.image_b_bootable}" = "0" && test "${multiboot}" = "1f0"; then
			setenv fiovb.is_secondary_boot "1"
		else
			setenv fiovb.is_secondary_boot "0"
		fi
	fi
else
	setenv check_secondary_boot "multi_boot"

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
