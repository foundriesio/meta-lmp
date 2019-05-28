FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

RDEPENDS_${PN}_append_sota = " u-boot-ostree-scr"
DEPENDS_remove_rpi = "rpi-u-boot-scr"

include u-boot-lmp-common.inc
