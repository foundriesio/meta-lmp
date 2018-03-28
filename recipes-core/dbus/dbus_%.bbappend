FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append += " \
	file://backport-modify-systemd-tmpfiles.d-create-var_lib_dbus.patch \
"
