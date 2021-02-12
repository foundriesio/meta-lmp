SUMMARY = "OP-TEE Client API"
DESCRIPTION = "Open Portable Trusted Execution Environment - Normal World Client side of the TEE"
HOMEPAGE = "https://www.op-tee.org/"

LICENSE = "BSD-2-Clause"
LIC_FILES_CHKSUM = "file://LICENSE;md5=69663ab153298557a59c67a60a743e5b"

inherit systemd

SRC_URI = " \
    git://github.com/OP-TEE/optee_client.git \
    file://tee-supplicant.service \
"

UPSTREAM_CHECK_GITTAGREGEX = "^(?P<pver>\d+(\.\d+)+)$"

S = "${WORKDIR}/git"

EXTRA_OEMAKE = "DESTDIR=${D} \
                CFG_TEE_FS_PARENT_PATH=${localstatedir}/tee \
                RPMB_EMU=0 \
               "

# Other security flags already maintained via flags.mk
SECURITY_CFLAGS = "${SECURITY_STACK_PROTECTOR}"

do_install() {
    oe_runmake install

    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/tee-supplicant.service ${D}${systemd_system_unitdir}

    chown -R root:root ${D}
}

SYSTEMD_SERVICE_${PN} = "tee-supplicant.service"
