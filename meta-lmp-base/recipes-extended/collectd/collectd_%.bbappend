FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI:append = " \
	file://tmpfiles.conf \
	file://collectd.conf \
"

PACKAGECONFIG = "rrdtool"

do_install:append() {
	install -D -m 0644 ${UNPACKDIR}/tmpfiles.conf ${D}${nonarch_libdir}/tmpfiles.d/collectd.conf
	install -D -m 0644 ${UNPACKDIR}/collectd.conf ${D}${sysconfdir}/collectd.conf
}

FILES:${PN} += "${nonarch_libdir}/tmpfiles.d/collectd.conf"
