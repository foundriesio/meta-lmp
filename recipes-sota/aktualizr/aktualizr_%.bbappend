FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

BRANCH_lmp = "2019.9+fio"
SRCREV_lmp = "a358242d9a9d1edc402144e50c4fc9f614bde067"

SRC_URI_lmp = "gitsm://github.com/foundriesio/aktualizr;branch=${BRANCH};name=aktualizr \
    file://aktualizr.service \
    file://aktualizr-lite.service \
    file://aktualizr-secondary.service \
    file://aktualizr-serialcan.service \
    file://10-resource-control.conf \
    ${@ d.expand("https://ats-tuf-cli-releases.s3-eu-central-1.amazonaws.com/cli-${GARAGE_SIGN_PV}.tgz;unpack=0;name=garagesign") if d.getVar('GARAGE_SIGN_AUTOVERSION') != '1' else ''} \
"

SRC_URI_append_libc-musl = " \
    file://utils.c-disable-tilde-as-it-is-not-supported-by-musl.patch \
"

PACKAGECONFIG[dockerapp] = "-DBUILD_DOCKERAPP=ON,-DBUILD_DOCKERAPP=OFF,,docker-app"
PACKAGECONFIG += "dockerapp"

SYSTEMD_PACKAGES += "${PN}-lite"
SYSTEMD_SERVICE_${PN}-lite = "aktualizr-lite.service"

do_install_append() {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/aktualizr-lite.service ${D}${systemd_system_unitdir}/
}

RDEPENDS_${PN}-lite = "aktualizr-configs lshw"
