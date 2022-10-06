#!/bin/sh
# Copyright (C) 2022 Foundries.IO Ltd.
# Licensed on MIT

uboot_env_enabled() {
	return 0
}

uboot_env_run() {
	mkdir -p /mnt/boot
	mount /mnt/boot
}
