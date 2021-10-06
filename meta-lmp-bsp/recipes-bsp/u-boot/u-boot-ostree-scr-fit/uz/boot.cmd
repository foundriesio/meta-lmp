# set default fdt_file
setenv fdt_file system-top.dtb
echo "Using ${fdt_file}"

# Default boot type and device
setenv bootlimit 3
setenv devtype mmc
setenv devnum 1
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

setenv update_primary_image 'echo "${fio_msg} writing ${image_path} ..."; mmc dev ${devnum} && fatwrite mmc ${devnum}:${bootpart} ${loadaddr} boot0001.bin ${filesize}';
setenv update_secondary_image 'echo "${fio_msg} writing ${image_path} ..."; mmc dev ${devnum} && fatwrite mmc ${devnum}:${bootpart} ${loadaddr} boot0002.bin ${filesize}';

setenv update_primary_image2 'echo "${fio_msg} writing ${image_path} ..."; mmc dev ${devnum} && fatwrite mmc ${devnum}:${bootpart} ${loadaddr} u-boot0001.itb ${filesize}';
setenv update_secondary_image2 'echo "${fio_msg} writing ${image_path} ..."; mmc dev ${devnum} && fatwrite mmc ${devnum}:${bootpart} ${loadaddr} u-boot0002.itb ${filesize}';

setenv check_board_closed "is_boot_authenticated"
setenv check_secondary_boot "multi_boot"
setenv set_primary_boot "multi_boot 1"
setenv set_secondary_boot "multi_boot 2"

@@INCLUDE_COMMON@@
