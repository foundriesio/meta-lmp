#!/bin/sh
# Copyright (C) 2022 Foundries.IO Ltd.
# Licensed on MIT

image_download_enabled() {
	# Disabled by default, to be replaced based on the target hardware
	return 1
}

image_download_run() {
	token=`fw_printenv -n osf_token`
	[ -z "$token" ] && fatal "Missing osf_token u-boot env definition"
	source /etc/os-release
	# Example for using wget to download via a token stored in u-boot env
	wget --header="OSF-TOKEN: $token" https://api.foundries.io/projects/${LMP_FACTORY}/lmp/builds/${IMAGE_VERSION}/runs/${LMP_MACHINE}/lmp-factory-image-${LMP_MACHINE}.wic.gz
}
