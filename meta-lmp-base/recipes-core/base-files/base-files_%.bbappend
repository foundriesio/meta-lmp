FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://tmpfiles.conf"

# fstab handling when var is in a separated partition (required by ostree)
OSTREE_SPLIT_VAR ?= "0"

do_compile:append () {
    if ${@bb.utils.contains('OSTREE_SPLIT_VAR', '1', 'true', 'false', d)}; then
        if ! grep -q '/var[[:blank:]]' ${WORKDIR}/fstab; then
            echo "LABEL=var    /var    ext4    defaults    0  1" >> ${WORKDIR}/fstab
        fi
    fi
}

do_install:append () {
    if ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', 'true', 'false', d)}; then
        install -D -m 0644 ${WORKDIR}/tmpfiles.conf ${D}${nonarch_libdir}/tmpfiles.d/${PN}.conf
    fi
}

FILES:${PN} += "${nonarch_libdir}/tmpfiles.d/${PN}.conf"

BASEFILESISSUEINSTALL = ""
