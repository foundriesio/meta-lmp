FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://system-generator-alsa-states"

# Install vendor-specific asound-*.state filed into
# /usr/lib/alsa/.
VAR_STATEDIR  = "${localstatedir}/lib/alsa"
SYS_STATEDIR = "${prefix}/lib/alsa"

do_install() {
    install -d ${D}${sysconfdir}
    install -m 0644 ${WORKDIR}/*.conf ${D}${sysconfdir}/
    install -d ${D}${SYS_STATEDIR}
    install -m 0644 ${WORKDIR}/*.state ${D}${SYS_STATEDIR}/

    # create link to support all packages configuration
    for p in a b c d e f;
    do
        for n in 1 3 7;
        do
            cd ${D}${sysconfdir}/
            ln -sf asound-stm32mp15yx-ev.conf asound-stm32mp15$n$p-ev.conf
            ln -sf asound-stm32mp15yx-dk.conf asound-stm32mp15$n$p-dk.conf
            cd ${D}${SYS_STATEDIR}
            ln -sf asound-stm32mp15yx-ev.state asound-stm32mp15$n$p-ev.state
            ln -sf asound-stm32mp15yx-dk.state asound-stm32mp15$n$p-dk.state
        done
    done

    # Enable systemd automatic selection
    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
        install -d ${D}${systemd_unitdir}/system-generators/
        install -m 0755 ${WORKDIR}/system-generator-alsa-states ${D}${systemd_unitdir}/system-generators/
        sed -i -e "s:#VARSTATEDIR#:${VAR_STATEDIR}:g" \
               -e "s:#SYSSTATEDIR#:${SYS_STATEDIR}:g" \
            ${D}${systemd_unitdir}/system-generators/system-generator-alsa-states
        if [ -f ${WORKDIR}/system-generator-alsa-conf ]; then
            install -m 0755 ${WORKDIR}/system-generator-alsa-conf ${D}${systemd_unitdir}/system-generators/
        fi
    fi
}

FILES:${PN} += "${SYS_STATEDIR}/*.state"
