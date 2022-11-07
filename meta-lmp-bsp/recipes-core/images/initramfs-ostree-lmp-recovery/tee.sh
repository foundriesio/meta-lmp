#!/bin/sh
# Copyright (C) 2022 Foundries.IO Ltd.
# Licensed on MIT

tee_enabled() {
	return 0
}

tee_run() {
	/usr/sbin/tee-supplicant &
}
