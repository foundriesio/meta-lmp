FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# Disable firewalld-zone by default, but allow via packageconfig
PACKAGECONFIG[firewalld-zone] = "-Dfirewalld_zone=true,-Dfirewalld_zone=false"

SRC_URI += " \
	file://0001-85-nm-unmanaged.rules-do-not-manage-docker-bridges.patch \
"
