do_install_append_stm32mp1-disco() {
	ln -s fw_env.config.mmc ${D}${sysconfdir}/fw_env.config
}
