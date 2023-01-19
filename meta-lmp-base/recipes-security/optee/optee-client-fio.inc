SUMMARY = "OP-TEE Client API"
DESCRIPTION = "Open Portable Trusted Execution Environment - Normal World Client side of the TEE"
HOMEPAGE = "https://www.op-tee.org/"

LICENSE = "BSD-2-Clause"
LIC_FILES_CHKSUM = "file://LICENSE;md5=69663ab153298557a59c67a60a743e5b"

inherit systemd cmake pkgconfig

DEPENDS = "util-linux-libuuid"

SRC_URI = " \
    git://github.com/OP-TEE/optee_client.git;protocol=https;branch=master \
    file://tee-supplicant.service \
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
    install -D -p -m0644 ${WORKDIR}/tee-supplicant.service ${D}${systemd_system_unitdir}/tee-supplicant.service
}

SYSTEMD_SERVICE:${PN} = "tee-supplicant.service"
