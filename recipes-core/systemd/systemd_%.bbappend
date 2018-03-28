FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append += " \
	file://backport-tmpfiles_allow_create_symlink_on_directories.patch \
"
