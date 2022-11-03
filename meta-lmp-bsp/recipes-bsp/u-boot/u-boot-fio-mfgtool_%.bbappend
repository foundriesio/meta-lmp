FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

require u-boot-fio-bsp-common.inc

# disable branch protection to fix SPL size overrun issue
TOOLCHAIN_OPTIONS:append:mx8mp-nxp-bsp = ' -mbranch-protection=none'
