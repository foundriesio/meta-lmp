FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Depend on libedit as it has a more friendly license than readline (GPLv3)
DEPENDS += "libedit"

# Disable firewalld-zone by default, but allow via packageconfig
PACKAGECONFIG[firewalld-zone] = "--enable-firewalld-zone,--disable-firewalld-zone"

SRC_URI += " \
	file://0001-Add-client-build-support-for-editline-libedit.patch \
"
