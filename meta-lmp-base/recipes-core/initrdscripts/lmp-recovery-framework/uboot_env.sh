#!/bin/sh
# Copyright (C) 2022 Foundries.IO Ltd.
# Licensed on MIT

uboot_env_enabled() {
	# Disabled by default, to be replaced based on the target hardware
	return 1
}

uboot_env_run() {
	# Define a valid fw_env for u-boot env manipulation from userspace
	:
}
