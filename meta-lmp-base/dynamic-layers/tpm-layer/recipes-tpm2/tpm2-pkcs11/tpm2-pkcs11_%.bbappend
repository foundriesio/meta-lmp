FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://tmpfiles.conf"

EXTRA_OECONF += "--with-storedir=${localstatedir}/tpm2_pkcs11"

do_install:append() {
	if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
		install -D -m 0644 ${WORKDIR}/tmpfiles.conf ${D}${nonarch_libdir}/tmpfiles.d/tpm2-pkcs11.conf
	fi
}

FILES:${PN} += "${nonarch_libdir}/tmpfiles.d/tpm2-pkcs11.conf"
