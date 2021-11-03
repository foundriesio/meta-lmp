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

if test "${modeboot}" = "qspiboot"; then
	setenv qspi_bootloader_offset 0x0
	setenv qspi_bootloader_s_offset 0x50000
	setenv qspi_bootloader2_offset 0x100000
	setenv qspi_bootloader2_s_offset 0xaa0000

	setenv update_primary_image 'echo "${fio_msg} writing ${image_path} ..."; sf probe; sf update ${loadaddr} ${qspi_bootloader_offset} ${filesize}';
	setenv update_secondary_image 'echo "${fio_msg} writing ${image_path} ..."; sf probe; sf update ${loadaddr} ${qspi_bootloader_s_offset} ${filesize}';

	setenv update_primary_image2 'echo "${fio_msg} writing ${image_path} ..."; sf probe; sf update ${loadaddr} ${qspi_bootloader2_offset} ${filesize}';
	setenv update_secondary_image2 'echo "${fio_msg} writing ${image_path} ..."; sf probe; sf update ${loadaddr} ${qspi_bootloadea2_s_offset} ${filesize}';
	setenv set_primary_boot "multi_boot 0"
	setenv set_secondary_boot "multi_boot 10"
else
	setenv update_primary_image 'echo "${fio_msg} writing ${image_path} ..."; mmc dev ${devnum} && fatwrite mmc ${devnum}:${bootpart} ${loadaddr} boot0001.bin ${filesize}';
	setenv update_secondary_image 'echo "${fio_msg} writing ${image_path} ..."; mmc dev ${devnum} && fatwrite mmc ${devnum}:${bootpart} ${loadaddr} boot0002.bin ${filesize}';

	setenv update_primary_image2 'echo "${fio_msg} writing ${image_path} ..."; mmc dev ${devnum} && fatwrite mmc ${devnum}:${bootpart} ${loadaddr} u-boot0001.itb ${filesize}';
	setenv update_secondary_image2 'echo "${fio_msg} writing ${image_path} ..."; mmc dev ${devnum} && fatwrite mmc ${devnum}:${bootpart} ${loadaddr} u-boot0002.itb ${filesize}';
	setenv set_primary_boot "multi_boot 1"
	setenv set_secondary_boot "multi_boot 2"
fi

setenv check_board_closed "is_boot_authenticated"
setenv check_secondary_boot "multi_boot"

@@INCLUDE_COMMON@@
