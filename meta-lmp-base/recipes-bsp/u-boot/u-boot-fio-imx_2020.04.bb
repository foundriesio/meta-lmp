# Share fw_env and lmp.cfg with u-boot-fio
FILESEXTRAPATHS_prepend := "${THISDIR}/u-boot-fio:"

require u-boot-fio-common.inc

SRCREV = "4979a99482f7e04a3c1f4fb55e3182395ee8f710"
SRCBRANCH = "2020.04+fio-imx"
