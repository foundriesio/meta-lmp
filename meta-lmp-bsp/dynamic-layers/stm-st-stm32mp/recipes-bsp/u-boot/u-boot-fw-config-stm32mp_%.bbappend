do_install:append:stm32mp1-disco() {
	ln -s fw_env.config.mmc ${D}${sysconfdir}/fw_env.config
}
