SUMMARY = "OPTEE Client"
HOMEPAGE = "https://github.com/OP-TEE/optee_client"
LICENSE = "BSD"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=69663ab153298557a59c67a60a743e5b"

SRC_URI = "git://github.com/OP-TEE/optee_client.git \
    file://0001-Disable-RPMB_EMU-by-default-3.10.patch \
    file://tee-supplicant.service \
"

PV = "3.10.0"
SRCREV = "e7a4706e08c8fbdd53530868a6ac4937193dd73c"

DEFAULT_PREFERENCE = "-1"

S = "${WORKDIR}/git"

inherit systemd

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
