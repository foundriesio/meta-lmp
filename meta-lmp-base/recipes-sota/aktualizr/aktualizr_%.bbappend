FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

BRANCH_lmp = "2020.2+fio"
SRCREV_lmp = "fd631e6a0925f4c71669a62cf5e86d0da42bd387"

SRC_URI_lmp = "gitsm://github.com/foundriesio/aktualizr;branch=${BRANCH};name=aktualizr \
    file://aktualizr.service \
    file://aktualizr-lite.service \
    file://aktualizr-lite.path \
    file://aktualizr-secondary.service \
    file://aktualizr-serialcan.service \
    file://10-resource-control.conf \
    ${@ d.expand("https://ats-tuf-cli-releases.s3-eu-central-1.amazonaws.com/cli-${GARAGE_SIGN_PV}.tgz;unpack=0;name=garagesign") if d.getVar('GARAGE_SIGN_AUTOVERSION') != '1' else ''} \
"

SRC_URI_append_libc-musl = " \
    file://utils.c-disable-tilde-as-it-is-not-supported-by-musl.patch \
"

PACKAGECONFIG += "${@bb.utils.filter('SOTA_EXTRA_CLIENT_FEATURES', 'fiovb', d)}"
PACKAGECONFIG[fiovb] = ",,,optee-fiovb aktualizr-fiovb-env-rollback"
PACKAGECONFIG[dockerapp] = "-DBUILD_DOCKERAPP=ON,-DBUILD_DOCKERAPP=OFF,,docker-app"
PACKAGECONFIG_append_class-target = " dockerapp"
PACKAGECONFIG_remove_class-target_riscv64 = "dockerapp"

SYSTEMD_PACKAGES += "${PN}-lite"
SYSTEMD_SERVICE_${PN}-lite = "aktualizr-lite.service aktualizr-lite.path"

do_install_append() {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/aktualizr-lite.service ${D}${systemd_system_unitdir}/
    install -m 0644 ${WORKDIR}/aktualizr-lite.path ${D}${systemd_system_unitdir}/
}

# Force same RDEPENDS, packageconfig rdepends common to both
RDEPENDS_${PN}-lite = "${RDEPENDS_aktualizr}"
