FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

ALTERNATIVE_PRIORITY[resolv-conf] = "300"

SRC_URI_append = " \
	file://systemd-networkd-wait-online.service.in-use-any-by-d.patch \
	file://systemd-timesyncd-update.service \
"

do_install_append() {
	echo 'L+ /var/tmp - - - - /var/volatile/tmp' >> ${D}${sysconfdir}/tmpfiles.d/00-create-volatile.conf
	if [ ${@ oe.types.boolean('${VOLATILE_LOG_DIR}') } = True ]; then
		echo 'L+ /var/log - - - - /var/volatile/log' >> ${D}${sysconfdir}/tmpfiles.d/00-create-volatile.conf
	fi

	# Workaround for https://github.com/systemd/systemd/issues/11329
	install -m 0644 ${WORKDIR}/systemd-timesyncd-update.service ${D}${systemd_system_unitdir}
	ln -sf ../systemd-timesyncd-update.service ${D}${systemd_system_unitdir}/sysinit.target.wants/systemd-timesyncd-update.service
}
