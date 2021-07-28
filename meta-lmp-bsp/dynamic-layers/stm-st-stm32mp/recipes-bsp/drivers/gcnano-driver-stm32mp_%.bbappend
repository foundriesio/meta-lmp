# Based on linux-stm32mp.inc
do_install_append() {
    install -d ${D}/${sysconfdir}/modprobe.d
    echo "blacklist etnaviv" > ${D}/${sysconfdir}/modprobe.d/gcnano.conf
}

FILES_${PN} += "${sysconfdir}/modprobe.d"
