FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append += " file://inputrc.lmp"

do_install:append () {
	install -m 0644 ${WORKDIR}/inputrc.lmp ${D}${sysconfdir}/inputrc
}
