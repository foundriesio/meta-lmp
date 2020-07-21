EXTRA_OECONF += " --with-rundir=/run/sudo "

# Workaround for explict rmdir in do_install_append / oe-core
do_install_prepend() {
	mkdir -p ${D}/sudo
}

do_install_append() {
	# Explicitly remove the /run directory to avoid QA error
	rmdir -p --ignore-fail-on-non-empty ${D}/run/sudo
}
