FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

BRANCH_lmp = "master"
SRCREV_lmp = "4be89e29494d3d7e1ff912e50fa7ac3cd15624c5"

SRC_URI_lmp = "gitsm://github.com/foundriesio/aktualizr-lite;branch=${BRANCH};name=aktualizr \
    file://aktualizr.service \
    file://aktualizr-lite.service.in \
    file://aktualizr-secondary.service \
    file://aktualizr-serialcan.service \
    file://10-resource-control.conf \
    ${@ d.expand("https://tuf-cli-releases.ota.here.com/cli-${GARAGE_SIGN_PV}.tgz;unpack=0;name=garagesign") if not oe.types.boolean(d.getVar('GARAGE_SIGN_AUTOVERSION')) else ''} \
"

SRC_URI_append_libc-musl = " \
    file://utils.c-disable-tilde-as-it-is-not-supported-by-musl.patch \
"

PACKAGECONFIG += "${@bb.utils.filter('SOTA_EXTRA_CLIENT_FEATURES', 'fiovb', d)} libfyaml"
PACKAGECONFIG[fiovb] = ",,,optee-fiovb aktualizr-fiovb-env-rollback"
PACKAGECONFIG[ubootenv] = ",,u-boot-fw-utils,u-boot-fw-utils u-boot-default-env aktualizr-uboot-env-rollback"
PACKAGECONFIG[libfyaml] = ",,,libfyaml"

SYSTEMD_PACKAGES += "${PN}-lite"
SYSTEMD_SERVICE_${PN}-lite = "aktualizr-lite.service"

COMPOSE_HTTP_TIMEOUT ?= "60"

# Workaround as aktualizr is a submodule of aktualizr-lite
do_configure_prepend_lmp() {
    cd ${S}
    git log -1 --format=%h | tr -d '\n' > VERSION
    cp VERSION aktualizr/VERSION
}

do_compile_append_lmp() {
    sed -e 's/@@COMPOSE_HTTP_TIMEOUT@@/${COMPOSE_HTTP_TIMEOUT}/' ${WORKDIR}/aktualizr-lite.service.in > ${WORKDIR}/aktualizr-lite.service
}

do_install_prepend_lmp() {
    # link the path to config so aktualizr's do_install_append will find config files
    [ -e ${S}/config ] || ln -s ${S}/aktualizr/config ${S}/config
    # link so native build will find sota_tools
    [ -e ${B}/src ] || ln -s ${B}/aktualizr/src ${B}/src
}

do_install_append() {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/aktualizr-lite.service ${D}${systemd_system_unitdir}/
}

# Force same RDEPENDS, packageconfig rdepends common to both
RDEPENDS_${PN}-lite = "${RDEPENDS_aktualizr}"
