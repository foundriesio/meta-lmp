FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append += " file://inputrc.lmp"

do_install_append () {
	install -m 0644 ${WORKDIR}/inputrc.lmp ${D}${sysconfdir}/inputrc
}
