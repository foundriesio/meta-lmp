FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

BRANCH:lmp = "v85"
SRCREV:lmp = "35ebc64154c4bcc60f1108c228c0446e1c4940d7"

SRC_URI:lmp = "gitsm://github.com/foundriesio/aktualizr-lite;protocol=https;branch=${BRANCH};name=aktualizr \
    file://aktualizr.service \
    file://aktualizr-lite.service.in \
    file://aktualizr-secondary.service \
    file://aktualizr-serialcan.service \
    file://tmpfiles.conf \
    file://10-resource-control.conf \
    ${@ d.expand("https://tuf-cli-releases.ota.here.com/cli-${GARAGE_SIGN_PV}.tgz;unpack=0;name=garagesign") if not oe.types.boolean(d.getVar('GARAGE_SIGN_AUTOVERSION')) else ''} \
"

SRC_URI:append:libc-musl = " \
    file://utils.c-disable-tilde-as-it-is-not-supported-by-musl.patch \
"

PACKAGECONFIG[sota-tools] = "-DBUILD_SOTA_TOOLS=ON ${GARAGE_SIGN_OPS},-DBUILD_SOTA_TOOLS=OFF,glib-2.0 ostree,"
PACKAGECONFIG += "${@bb.utils.filter('SOTA_EXTRA_CLIENT_FEATURES', 'fiovb', d)} libfyaml"
PACKAGECONFIG[fiovb] = ",,,optee-fiovb aktualizr-fiovb-env-rollback"
PACKAGECONFIG[ubootenv] = ",,u-boot-fw-utils,u-boot-fw-utils u-boot-default-env aktualizr-uboot-env-rollback"
PACKAGECONFIG[libfyaml] = ",,,libfyaml"

SYSTEMD_PACKAGES += "${PN}-lite"
SYSTEMD_SERVICE:${PN}-lite = "aktualizr-lite.service"

COMPOSE_HTTP_TIMEOUT ?= "60"
DOCKER_CRED_HELPER_CFG ?= "${libdir}/docker/config.json"

# Workaround as aktualizr is a submodule of aktualizr-lite
do_configure:prepend:lmp() {
    cd ${S}
    git log -1 --format=%h | tr -d '\n' > VERSION
    cp VERSION aktualizr/VERSION
    cd ${B}
}

do_compile:append:lmp() {
    sed -e 's|@@COMPOSE_HTTP_TIMEOUT@@|${COMPOSE_HTTP_TIMEOUT}|g' \
        -e 's|@@DOCKER_CRED_HELPER_CFG@@|${DOCKER_CRED_HELPER_CFG}|g' \
        ${WORKDIR}/aktualizr-lite.service.in > ${WORKDIR}/aktualizr-lite.service
}

do_install:prepend:lmp() {
    # link the path to config so aktualizr's do_install:append will find config files
    [ -e ${S}/config ] || ln -s ${S}/aktualizr/config ${S}/config
    # link so native build will find sota_tools
    [ -e ${B}/src ] || ln -s ${B}/aktualizr/src ${B}/src
}

do_install:append:lmp() {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/aktualizr-lite.service ${D}${systemd_system_unitdir}/
    install -d ${D}${nonarch_libdir}/tmpfiles.d
    install -m 0644 ${WORKDIR}/tmpfiles.conf ${D}${nonarch_libdir}/tmpfiles.d/aktualizr-lite.conf
}

PACKAGES += "${PN}-get ${PN}-lite ${PN}-lite-lib ${PN}-lite-dev"
FILES:${PN}-get = "${bindir}/${PN}-get"
FILES:${PN}-lite = " \
                    ${bindir}/${PN}-lite \
                    ${nonarch_libdir}/tmpfiles.d/${PN}-lite.conf \
                    "
FILES:${PN}-lite-lib = "${nonarch_libdir}/lib${PN}_lite.so"
FILES:${PN}-lite-dev = "${includedir}/${PN}-lite"
FILES:${PN}-dev = " \
                   ${libdir}/pkgconfig/aktualizr.pc \
                   ${includedir}/libaktualizr \
                  "

# Force same RDEPENDS, packageconfig rdepends common to both
RDEPENDS:${PN}-lite = "${RDEPENDS:aktualizr} skopeo"
RDEPENDS:${PN}-lite-lib = "${RDEPENDS:aktualizr} skopeo"
