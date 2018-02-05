FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
	file://libacpi_fix_libdir.patch \
"

do_install_append() {
	# Run make install a second time with the right libdir
	rm -rf ${D}
	oe_runmake install DESTDIR=${D} PREFIX=${exec_prefix} LIBDIR=${libdir}
}
