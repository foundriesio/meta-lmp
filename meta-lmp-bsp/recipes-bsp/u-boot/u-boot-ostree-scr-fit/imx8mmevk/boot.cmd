echo "Using freescale_${fdt_file}"

# Default boot type and device
setenv bootlimit 3
setenv devtype mmc
setenv devnum 2

# FIO bootcount, upgrade_available and rollback initialization
mmc rescan
fiovb init {devnum}
fiovb is_secondary_boot

if test ${fiovb.is_secondary_boot} -eq 0; then
	fiovb read_pvalue bootcount 4
	if test ! $? -eq 0; then fiovb write_pvalue bootcount 0; fi

	fiovb read_pvalue rollback 4
	if test ! $? -eq 0; then fiovb write_pvalue rollback 0; fi

	fiovb read_pvalue upgrade_available 4
	if test ! $? -eq 0; then fiovb write_pvalue upgrade_available 0; fi

	# Only update bootcount when upgrade_available is set
	if test ${fiovb.upgrade_available} -eq 1; then
		setexpr bootcount ${fiovb.bootcount} + 1;
		fiovb write_pvalue bootcount ${bootcount};

		# If bootcount is above bootlimit, trigger rollback
		# if not - try to boot secondary boot path for boot firmware validation
		if test ${bootcount} -gt ${bootlimit}; then
			fiovb write_pvalue rollback 1;
			fiovb write_pvalue upgrade_available 0;
		else
			fiovb set_secondary_boot 1;
			imx_warm_reset;
		fi
	fi

fi

setenv bootcmd_resetvars 'setenv kernel_image; setenv bootargs; setenv kernel_image2; setenv bootargs2'
setenv bootcmd_otenv 'run bootcmd_resetvars; ext4load ${devtype} ${devnum}:2 ${loadaddr} /boot/loader/uEnv.txt; env import -t ${loadaddr} ${filesize}'
setenv bootcmd_load_f 'ext4load ${devtype} ${devnum}:2 ${initrd_addr} "/boot"${kernel_image}'
setenv bootcmd_run 'bootm ${initrd_addr}#conf@freescale_${fdt_file}'
# We do a rollback only from primary boot image
setenv bootcmd_rollback 'if test -n "${kernel_image2}" && test "${fiovb.is_secondary_boot}" = 0 && test "${fiovb.rollback}" = 1; setenv kernel_image ${kernel_image2}; setenv bootargs ${bootargs2}'
setenv bootostree 'run bootcmd_load_f; run bootcmd_run'
setenv bootcmdfinal 'run bootcmd_otenv; run bootcmd_rollback; run bootostree;'

run bootcmdfinal
reset
