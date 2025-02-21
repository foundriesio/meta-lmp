SUMMARY = "OP-TEE Client API"
DESCRIPTION = "Open Portable Trusted Execution Environment - Normal World Client side of the TEE"
HOMEPAGE = "https://www.op-tee.org/"

LICENSE = "BSD-2-Clause"
LIC_FILES_CHKSUM = "file://LICENSE;md5=69663ab153298557a59c67a60a743e5b"

inherit systemd cmake pkgconfig useradd_base

DEPENDS = "util-linux-libuuid"

SRC_URI = " \
    git://github.com/OP-TEE/optee_client.git;protocol=https;branch=master \
    file://tee-supplicant@.service \
    file://tee-supplicant.sh \
    file://optee-udev.rules \
"

UPSTREAM_CHECK_GITTAGREGEX = "^(?P<pver>\d+(\.\d+)+)$"

S = "${WORKDIR}/git"

EXTRA_OECMAKE = " \
    -DBUILD_SHARED_LIBS=ON \
    -DRPMB_EMU=OFF \
    -DCFG_TEE_FS_PARENT_PATH='${localstatedir}/tee' \
"
EXTRA_OECMAKE:append:toolchain-clang = " -DCFG_WERROR=0"

do_install:append() {
    install -D -p -m0644 ${WORKDIR}/tee-supplicant@.service ${D}${systemd_system_unitdir}/tee-supplicant@.service
    install -D -p -m0755 ${WORKDIR}/tee-supplicant.sh ${D}${sysconfdir}/init.d/tee-supplicant
    install -d ${D}${sysconfdir}/udev/rules.d
    install -m 0644 ${WORKDIR}/optee-udev.rules ${D}${sysconfdir}/udev/rules.d/optee.rules

    sed -i -e s:@sysconfdir@:${sysconfdir}:g \
           -e s:@sbindir@:${sbindir}:g \
              ${D}${systemd_system_unitdir}/tee-supplicant@.service \
              ${D}${sysconfdir}/init.d/tee-supplicant
}

SYSTEMD_SERVICE:${PN} = "tee-supplicant@.service"

INITSCRIPT_PACKAGES = "${PN}"
INITSCRIPT_NAME:${PN} = "tee-supplicant"
INITSCRIPT_PARAMS:${PN} = "start 10 1 2 3 4 5 . stop 90 0 6 ."

USERADD_PACKAGES = "${PN}"
GROUPADD_PARAM:${PN} = "--system teeclnt"
