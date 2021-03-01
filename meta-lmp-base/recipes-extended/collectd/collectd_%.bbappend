FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI += " \
	file://tmpfiles.conf \
	file://collectd.conf \
"

PACKAGECONFIG = "rrdtool"

do_install_append() {
	install -D -m 0644 ${WORKDIR}/tmpfiles.conf ${D}${nonarch_libdir}/tmpfiles.d/collectd.conf
	install -D -m 0644 ${WORKDIR}/collectd.conf ${D}${sysconfdir}/collectd.conf
}

FILES_${PN} += "${nonarch_libdir}/tmpfiles.d/collectd.conf"
