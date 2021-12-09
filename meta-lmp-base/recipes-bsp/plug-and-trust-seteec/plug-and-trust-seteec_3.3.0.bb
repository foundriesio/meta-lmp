DESCRIPTION = "NXP Plug and Trust Middleware with SETEEC support"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

SRC_URI = "git://github.com/foundriesio/plug-and-trust-seteec;branch=main;protocol=https"
SRCREV = "e6d4a8d81a09a980ab95a9e82a0551076a6a3e52"

DEPENDS = "openssl optee-client"

inherit cmake dos2unix

S = "${WORKDIR}/git"

EL2GO_HOSTNAME ?= "DEFAULTHOSTNAME"

EXTRA_OECMAKE += "\
    -DWithSharedLIB=ON -DCMAKE_BUILD_TYPE=Debug -DHost=iMXLinux -DHostCrypto=OPENSSL \
    -DSMCOM=T1oI2C -DSE05X_Auth=None -DApplet=SE05X_C -DSE05X_Ver=03_XX \
    -DOPENSSL_INSTALL_PREFIX=${WORKDIR}/recipe-sysroot/usr \
    -DOPENSSL_ROOT_DIR=${WORKDIR}/recipe-sysroot/usr \
    -DPAHO_ENABLE_TESTING=FALSE -DPAHO_ENABLE_CPACK=FALSE -DPAHO_WITH_SSL=TRUE \
    -DWithSETEEC=ON -DEL2GO_HOSTNAME="${EL2GO_HOSTNAME}" \
"

do_install_append() {
    install -d ${D}${sysconfdir}/ssl
    install -m 0644 ${S}/nxp_iot_agent/ex/src/openssl_conf_v111.cnf ${D}${sysconfdir}/ssl/openssl_conf_sss.cnf
}

FILES_${PN} += "\
    ${libdir}/liba7x_utils.so \
    ${libdir}/libex_common.so \
    ${libdir}/libmwlog.so \
    ${libdir}/libnxp_iot_agent_common.so \
    ${libdir}/libnxp_iot_agent.so \
    ${libdir}/libse05x.so \
    ${libdir}/libsmCom.so \
    ${libdir}/libSSS_APIs.so \
    ${libdir}/libsssapisw.so \
    ${libdir}/libsss_engine.so \
"
FILES_${PN}-dev = "${includedir} ${libdir}/libpaho*.so ${libdir}/cmake ${datadir}/cmake ${datadir}/se05x"
