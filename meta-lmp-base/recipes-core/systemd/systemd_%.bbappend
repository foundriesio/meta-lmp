FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

ALTERNATIVE_PRIORITY[resolv-conf] = "300"

SRC_URI_append = " \
	file://systemd-networkd-wait-online.service.in-use-any-by-d.patch \
	file://systemd-timesyncd-update.service \
"

SRC_URI_MUSL_append = " \
	file://0001-Include-netinet-if_ether.h.patch \
"

PACKAGECONFIG_append_libc-musl = " resolved-musl"
PACKAGECONFIG[resolved-musl] = "-Dresolve=true,"
USERADD_PARAM_${PN} += "${@bb.utils.contains('PACKAGECONFIG', 'resolved-musl', '--system -d / -M --shell /bin/nologin systemd-resolve;', '', d)}"
ALTERNATIVE_${PN} += " ${@bb.utils.contains('PACKAGECONFIG', 'resolved-musl', 'resolv-conf', '', d)}"

do_install_append() {
	echo 'L+ /var/tmp - - - - /var/volatile/tmp' >> ${D}${sysconfdir}/tmpfiles.d/00-create-volatile.conf
	if [ ${@ oe.types.boolean('${VOLATILE_LOG_DIR}') } = True ]; then
		echo 'L+ /var/log - - - - /var/volatile/log' >> ${D}${sysconfdir}/tmpfiles.d/00-create-volatile.conf
	else
		# Make sure /var/log is not a link to volatile (e.g. after system updates)
		sed -i '/\[Service\]/aExecStartPre=-/bin/rm -f /var/log' ${D}${systemd_system_unitdir}/systemd-journal-flush.service
	fi

	# Workaround for https://github.com/systemd/systemd/issues/11329
	install -m 0644 ${WORKDIR}/systemd-timesyncd-update.service ${D}${systemd_system_unitdir}
	ln -sf ../systemd-timesyncd-update.service ${D}${systemd_system_unitdir}/sysinit.target.wants/systemd-timesyncd-update.service

	# Workaround to avoid replacing the systemd recipe when building with musl
	if ${@bb.utils.contains('PACKAGECONFIG', 'resolved-musl', 'true', 'false', d)}; then
		sed -i -e "s%^L! /etc/resolv.conf.*$%L! /etc/resolv.conf - - - - ../run/systemd/resolve/resolv.conf%g" ${D}${exec_prefix}/lib/tmpfiles.d/etc.conf
	fi
}
