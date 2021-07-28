FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append = " \
    file://galcore.rules \
"

# Based on linux-stm32mp.inc
do_install_append() {
    install -d ${D}/${sysconfdir}/modprobe.d
    echo "blacklist etnaviv" > ${D}/${sysconfdir}/modprobe.d/gcnano.conf

    install -d ${D}${nonarch_base_libdir}/udev/rules.d
    install -m 0644 ${WORKDIR}/galcore.rules ${D}${nonarch_base_libdir}/udev/rules.d/80-galcore.rules
}

FILES_${PN} += "${sysconfdir}/modprobe.d ${nonarch_base_libdir}/udev/rules.d"
