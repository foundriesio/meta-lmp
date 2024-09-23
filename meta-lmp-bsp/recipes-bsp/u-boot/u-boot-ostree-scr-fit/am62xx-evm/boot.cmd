# Default boot type and device
setenv bootlimit 3
setenv devtype mmc
setenv devnum 0
setenv bootpart 1
setenv rootpart 2

setenv loadaddr 0x90000000
setenv fit_addr "${loadaddr}"

setenv bootcmd_custom_run 'run findfdt; run get_fit_config; bootm ${fit_addr}#${name_fit_config}${dtoverlay}'

setenv bootloader1_src_image "tiboot3-am62x-gp-evm.bin"
setenv board_is_closed "0"

if test "${device_type}" = "hs-fs"; then
setenv bootloader1_src_image "tiboot3-am62x-hs-fs-evm.bin"
setenv board_is_closed "0"
fi
if test "${device_type}" = "hs-se"; then
setenv bootloader1_src_image "tiboot3-am62x-hs-evm.bin"
setenv board_is_closed "1"
fi

setenv bootloader2_src_image "tispl.bin"
setenv bootloader3_src_image "u-boot.img"
setenv bootloader4_src_image "boot.itb"

setenv bootloader1_image "tiboot3.bin"
setenv bootloader2_image "${bootloader2_src_image}"
setenv bootloader3_image "${bootloader3_src_image}"
setenv bootloader4_image "${bootloader4_src_image}"

setenv copy_img 'fatload ${devtype} ${devnum}:${bootpart} ${loadaddr} ${file_src} && setenv run_update "${update_cmd} ${file_dst} ${filesize}"; run run_update'
setenv backup_primary_image 'echo "${fio_msg} backup primary boot image set ..."; setenv file_src ${bootloader1_image} && setenv file_dst ${bootloader1_image}.bck && run copy_img && setenv file_src ${bootloader2_image} && setenv file_dst ${bootloader2_image}.bck && run copy_img && setenv file_src ${bootloader3_image} && setenv file_dst ${bootloader3_image}.bck && run copy_img && setenv file_src ${bootloader4_image} && setenv file_dst ${bootloader4_image}.bck && run copy_img'
setenv restore_primary_image 'echo "${fio_msg} restore primary boot image set ..."; setenv file_src ${bootloader1_image}.bck && setenv file_dst ${bootloader1_image} && run copy_img && setenv file_src ${bootloader2_image}.bck && setenv file_dst ${bootloader2_image} && run copy_img && setenv file_src ${bootloader3_image}.bck && setenv file_dst ${bootloader3_image} && run copy_img && setenv file_src ${bootloader4_image}.bck && setenv file_dst ${bootloader4_image} && run copy_img'
setenv check_secondary_boot "setenv fiovb.is_secondary_boot 0"
setenv check_board_closed "true"

setenv setup_update 'setenv update_cmd "mmc dev ${devnum} && fatwrite mmc ${devnum}:${bootpart} ${loadaddr}"'
setenv update_pri 'if test "${ostree_deploy_usr}" = "1"; then setenv image_path "${bootdir}/${bootloader_src_image}"; else setenv image_path "${ostree_root}/usr/lib/firmware/${bootloader_src_image}"; fi; run load_image && setenv run_update "${update_cmd} ${bootloader_image} ${filesize}"; echo "${fio_msg} update image ${bootloader_image}, using ${image_path} ..."; run run_update'

setenv update_primary_image 'setenv bootloader_image ${bootloader1_image} && setenv bootloader_src_image ${bootloader1_src_image} && run update_pri && setenv bootloader_image ${bootloader2_image} && setenv bootloader_src_image ${bootloader2_src_image} && run update_pri && setenv bootloader_image ${bootloader3_image} && setenv bootloader_src_image ${bootloader3_src_image} && run update_pri && setenv bootloader_image ${bootloader4_image} && setenv bootloader_src_image ${bootloader4_src_image} && run update_pri'

setenv do_reboot "reset"

if test ! -e ${devtype} ${devnum}:1 uboot.env; then saveenv; fi

run setup_update

@@INCLUDE_COMMON_ALTERNATIVE@@
