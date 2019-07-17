SUMMARY = "OPTEE Client"
HOMEPAGE = "https://github.com/OP-TEE/optee_client"
LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=69663ab153298557a59c67a60a743e5b"

SRC_URI = "git://github.com/OP-TEE/optee_client.git \
           file://tee-supplicant.service"

PV = "3.6.0"
SRCREV = "1cdf49d9259ad83c3fbdf416e5ea223a18a28da8"

S = "${WORKDIR}/git"

inherit pythonnative systemd

SYSTEMD_SERVICE_${PN} = "tee-supplicant.service"

EXTRA_OEMAKE = "DESTDIR=${D} CFG_TEE_FS_PARENT_PATH=${localstatedir}/tee"

# Other security flags already maintained via flags.mk
SECURITY_CFLAGS = "${SECURITY_STACK_PROTECTOR}"

do_install() {
    oe_runmake install

    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/tee-supplicant.service ${D}${systemd_system_unitdir}

    chown -R root:root ${D}
}
