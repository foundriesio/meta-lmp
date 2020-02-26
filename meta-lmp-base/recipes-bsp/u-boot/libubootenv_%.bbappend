FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " file://fw_env.config"

FILES_${PN}-bin += "${sysconfdir}/fw_env.config"

PACKAGE_ARCH = "${MACHINE_ARCH}"

do_install_append () {
	install -d ${D}${sysconfdir}
	install -m 0644 ${WORKDIR}/fw_env.config ${D}${sysconfdir}/fw_env.config
}
