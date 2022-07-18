SUMMARY = "NXP Wi-Fi driver for module 88w8997/8987"
LICENSE = "GPL-2.0-only"
LIC_FILES_CHKSUM = "file://gpl-2.0.txt;md5=ab04ac0f249af12befccb94447c08b77"

SRCBRANCH = "lf-5.10.72_2.2.0"
MRVL_SRC ?= "git://source.codeaurora.org/external/imx/mwifiex.git;protocol=https"
SRC_URI = "${MRVL_SRC};branch=${SRCBRANCH}"
SRCREV = "3c2a3c2cd25e9dce95f34c21bb4e728647eb64ee"

DEPENDS += "virtual/kernel"

S = "${WORKDIR}/git/mxm_wifiex/wlan_src"

inherit module

EXTRA_OEMAKE = "KERNELDIR=${STAGING_KERNEL_BUILDDIR} -C ${STAGING_KERNEL_BUILDDIR} M=${S}"

INHIBIT_PACKAGE_DEBUG_SPLIT = "${@bb.utils.contains('DISTRO_FEATURES', 'modsign', '1', '', d)}"
