FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Avoid conflicts with busybox
ALTERNATIVE_${PN} += " halt reboot poweroff"

ALTERNATIVE_TARGET[halt] = "${base_bindir}/systemctl"
ALTERNATIVE_LINK_NAME[halt] = "${base_sbindir}/halt"
ALTERNATIVE_PRIORITY[halt] ?= "300"

ALTERNATIVE_TARGET[reboot] = "${base_bindir}/systemctl"
ALTERNATIVE_LINK_NAME[reboot] = "${base_sbindir}/reboot"
ALTERNATIVE_PRIORITY[reboot] ?= "300"

ALTERNATIVE_TARGET[poweroff] = "${base_bindir}/systemctl"
ALTERNATIVE_LINK_NAME[poweroff] = "${base_sbindir}/poweroff"
ALTERNATIVE_PRIORITY[poweroff] ?= "300"

SRC_URI_append += " \
	file://tmpfiles.d-var.conf-also-create-var-lib-misc.patch \
"

do_install_append() {
	echo 'L+ /var/tmp - - - - /var/volatile/tmp' >> ${D}${sysconfdir}/tmpfiles.d/00-create-volatile.conf
	if [ ${@ oe.types.boolean('${VOLATILE_LOG_DIR}') } = True ]; then
		echo 'L+ /var/log - - - - /var/volatile/log' >> ${D}${sysconfdir}/tmpfiles.d/00-create-volatile.conf
	fi
}
