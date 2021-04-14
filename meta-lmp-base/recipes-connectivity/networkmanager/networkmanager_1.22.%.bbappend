FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Depend on libedit as it has a more friendly license than readline (GPLv3)
DEPENDS += "libedit"

SRC_URI += " \
	file://0001-Add-client-build-support-for-editline-libedit.patch \
"
