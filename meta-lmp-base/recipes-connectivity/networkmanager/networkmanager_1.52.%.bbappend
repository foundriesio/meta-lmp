FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# Disable firewalld-zone by default, but allow via packageconfig
PACKAGECONFIG[firewalld-zone] = "-Dfirewalld_zone=true,-Dfirewalld_zone=false"

SRC_URI:append = " \
	file://0001-85-nm-unmanaged.rules-do-not-manage-docker-bridges.patch \
"

do_install:append() {
	# NM is able to create /var/lib/NetworkManager on runtime
	(cd ${D}${localstatedir}; rmdir -v --parents lib/NetworkManager)
}

PV = "1.54.0"
SRCREV = "37dbdd3199cfd369a49d03888e75491f92dfbbfa"
