FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

BCM_BT_SOURCES_append = " \
	file://brcm43438-osf.service \
"

enable_bcm_bluetooth_append() {
	if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
		install -m 0644 ${WORKDIR}/brcm43438-osf.service ${D}${systemd_unitdir}/system/brcm43438.service
	fi
}
