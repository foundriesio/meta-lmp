#!/bin/sh
# Copyright (C) 2022 Foundries.IO Ltd.
# Licensed on MIT

udhcpc_enabled() {
	# Disabled by default, to be replaced based on the target hardware
	return 1
}

udhcpc_run() {
	udhcpc
}
