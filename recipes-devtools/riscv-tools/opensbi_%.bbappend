do_install_append() {
	# HACK: fix build break by deleting lib/*
	rm -r ${D}/lib/
}
