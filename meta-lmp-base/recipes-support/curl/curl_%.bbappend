FILESEXTRAPATHS:prepend := "${THISDIR}/files:"

SRC_URI += "file://0001-openssl-fix-CN-check-error-code.patch"

EXTRA_OECONF:append:sota = " \
    --with-ca-path=${sysconfdir}/ssl/certs \
"
