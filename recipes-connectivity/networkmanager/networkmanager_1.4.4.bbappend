FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://0001-dns-resolved-add-systemd-resolved-backend.patch \
    file://0001-dns-resolved-also-check-for-etc-resolv-conf.systemd.patch \
"
