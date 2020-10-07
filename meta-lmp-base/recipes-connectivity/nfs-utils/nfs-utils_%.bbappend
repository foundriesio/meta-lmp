FILESEXTRAPATHS_prepend := "${THISDIR}/${BPN}:"

SRC_URI += "file://tmpfiles.conf"

do_install_append() {
	install -D -m 0644 ${WORKDIR}/tmpfiles.conf ${D}${nonarch_libdir}/tmpfiles.d/nfs-utils.conf
}

FILES_${PN} += "${nonarch_libdir}/tmpfiles.d/nfs-utils.conf"
