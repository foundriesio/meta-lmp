# Foundries U-Boot LOCALVERSION extension
#
# This allow to easy reuse of code between different U-Boot recipes
#
# The following options are supported:
#
#  SCMVERSION        Puts the Git hash in U-Boot local version
#  LOCALVERSION      Value used in LOCALVERSION (default to '+fio')
#
# Copyright 2014 (C) O.S. Systems Software LTDA.
# Copyright 2021 (C) Foundries.IO LTD

SCMVERSION ??= "y"
LOCALVERSION ??= "+fio"

UBOOT_LOCALVERSION = "${LOCALVERSION}"

do_compile_prepend() {
	if [ "${SCMVERSION}" = "y" ]; then
		# Add GIT revision to the local version
		head=`cd ${S} ; git rev-parse --verify --short HEAD 2> /dev/null`
		printf "%s%s%s" "${UBOOT_LOCALVERSION}" +g $head > ${S}/.scmversion
		printf "%s%s%s" "${UBOOT_LOCALVERSION}" +g $head > ${B}/.scmversion
	else
		printf "%s" "${UBOOT_LOCALVERSION}" > ${S}/.scmversion
		printf "%s" "${UBOOT_LOCALVERSION}" > ${B}/.scmversion
	fi
}
