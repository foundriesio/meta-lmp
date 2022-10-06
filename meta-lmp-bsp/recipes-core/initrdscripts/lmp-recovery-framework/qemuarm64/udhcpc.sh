#!/bin/sh
# Copyright (C) 2022 Foundries.IO Ltd.
# Licensed on MIT

udhcpc_enabled() {
	return 0
}

udhcpc_run() {
	udhcpc -i enp0s1
}
