#!/bin/sh
# Copyright (C) 2022 Foundries.IO Ltd.
# Licensed on MIT

start_adb_enabled() {
        return 0
}

start_adb_run() {
	mount -t configfs none /sys/kernel/config
	test -c /dev/ptmx || mknod -m 666 /dev/ptmx c 5 2
	mkdir -p /dev/pts
	mount -t devpts devpts /dev/pts -ogid=5,mode=620
	/bin/android-gadget-setup
	/bin/android-gadget-start &
	/bin/adbd
}
