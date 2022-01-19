FILESEXTRAPATHS:prepend := "${THISDIR}/${BPN}:"

SRC_URI += "file://tmpfiles.conf"

do_install:append() {
	install -D -m 0644 ${WORKDIR}/tmpfiles.conf ${D}${nonarch_libdir}/tmpfiles.d/nfs-utils.conf
}

FILES:${PN} += "${nonarch_libdir}/tmpfiles.d/nfs-utils.conf"
