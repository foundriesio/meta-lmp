SUMMARY = "OP-TEE Client API"
DESCRIPTION = "Open Portable Trusted Execution Environment - Normal World Client side of the TEE"
HOMEPAGE = "https://www.op-tee.org/"

LICENSE = "BSD-2-Clause"
LIC_FILES_CHKSUM = "file://LICENSE;md5=69663ab153298557a59c67a60a743e5b"

inherit systemd cmake pkgconfig useradd

DEPENDS = "util-linux-libuuid"

SRC_URI = " \
    git://github.com/OP-TEE/optee_client.git;protocol=https;branch=master \
"

UPSTREAM_CHECK_GITTAGREGEX = "^(?P<pver>\d+(\.\d+)+)$"

EXTRA_OECMAKE = " \
    -DBUILD_SHARED_LIBS=ON \
    -DRPMB_EMU=OFF \
    -DCFG_TEE_FS_PARENT_PATH='${localstatedir}/tee' \
    -DCFG_TEE_GROUP='teeclnt' \
    -DCFG_TEEPRIV_GROUP='teeclnt' \
    -DCFG_TEE_SUPPL_USER='root' \
    -DCFG_TEE_SUPPL_GROUP='root' \
"
EXTRA_OECMAKE:append:toolchain-clang = " -DCFG_WERROR=0"

SYSTEMD_SERVICE:${PN} = "tee-supplicant@.service"

USERADD_PACKAGES = "${PN}"
GROUPADD_PARAM:${PN} = "--system teeclnt"
