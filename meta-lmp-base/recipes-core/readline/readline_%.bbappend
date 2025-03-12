FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://inputrc.lmp"

do_install:append () {
	install -m 0644 ${UNPACKDIR}/inputrc.lmp ${D}${sysconfdir}/inputrc
}
