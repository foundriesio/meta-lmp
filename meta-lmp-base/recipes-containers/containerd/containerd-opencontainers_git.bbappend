# Use upstream containerd.service file
do_install_append() {
	if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
		# adjust from /usr/local/bin to /usr/bin/
		sed -e "s:/usr/local/bin/containerd:${bindir}/docker-containerd:g" \
			${S}/src/import/containerd.service > \
			${D}/${systemd_unitdir}/system/containerd.service
	fi
}
