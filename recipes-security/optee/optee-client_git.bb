SUMMARY = "OPTEE Client"
HOMEPAGE = "https://github.com/OP-TEE/optee_client"
LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=69663ab153298557a59c67a60a743e5b"

SRC_URI = "git://github.com/OP-TEE/optee_client.git \
           file://tee-supplicant.service"

PV = "3.4.0+git${SRCPV}"
SRCREV = "34d4375ab4460ad3af83c0af8ff35d6b391b75b3"

S = "${WORKDIR}/git"

inherit pythonnative systemd

SYSTEMD_SERVICE_${PN} = "tee-supplicant.service"

EXTRA_OEMAKE = "DESTDIR=${D}"

do_install() {
    oe_runmake install

    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/tee-supplicant.service ${D}${systemd_system_unitdir}

    chown -R root:root ${D}
}
