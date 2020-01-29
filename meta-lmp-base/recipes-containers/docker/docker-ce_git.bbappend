SRCREV_docker = "633a0ea838f10e000b7c6d6eed1623e6e988b5bb"

DOCKER_VERSION = "19.03.5-ce"

do_install_prepend() {
	# Final dockerd binary location has been moved. Work around by creating
	# a symlink instead of overwriting the complete do_install task.
	mkdir -p ${S}/src/import/components/engine/bundles/latest/
	ln -sf ${S}/src/import/components/engine/bundles/dynbinary-daemon/ \
		${S}/src/import/components/engine/bundles/latest/dynbinary-daemon
}
