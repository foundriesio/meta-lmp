FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
	file://0001-lib-ecdh1-derive-simple-implementation-for-KDF-null.patch \
	file://0001-backend-do-not-initialize-fapi-when-not-enabled.patch \
	file://0002-db-don-t-warn-the-user-when-db-is-not-found.patch \
	file://0001-sign-skip-pkey-when-signing-during-sign_init.patch \
	file://tmpfiles.conf \
"

EXTRA_OECONF += "--with-storedir=${localstatedir}/tpm2_pkcs11"

do_install:append() {
	if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
		install -D -m 0644 ${WORKDIR}/tmpfiles.conf ${D}${nonarch_libdir}/tmpfiles.d/tpm2-pkcs11.conf
	fi
}

FILES:${PN} += "${nonarch_libdir}/tmpfiles.d/tpm2-pkcs11.conf"
