FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

BRANCH_lmp = "2019.8+fio"
SRCREV_lmp = "eb5e8b5bc0106ce45450d894c846f1aecbd6191f"

SRC_URI_lmp = "gitsm://github.com/foundriesio/aktualizr;branch=${BRANCH} \
    file://aktualizr.service \
    file://aktualizr-lite.service \
    file://aktualizr-secondary.service \
    file://aktualizr-serialcan.service \
    file://10-resource-control.conf \
    ${@ d.expand("https://ats-tuf-cli-releases.s3-eu-central-1.amazonaws.com/cli-${GARAGE_SIGN_PV}.tgz;unpack=0") if d.getVar('GARAGE_SIGN_AUTOVERSION') != '1' else ''} \
"

SRC_URI_append_libc-musl = " \
    file://utils.c-disable-tilde-as-it-is-not-supported-by-musl.patch \
"

PACKAGECONFIG[dockerapp] = "-DBUILD_DOCKERAPP=ON,-DBUILD_DOCKERAPP=OFF,"
PACKAGECONFIG += "dockerapp"

SYSTEMD_PACKAGES += "${PN}-lite"
SYSTEMD_SERVICE_${PN}-lite = "aktualizr-lite.service"

do_install_append() {
    install -d ${D}${systemd_system_unitdir}
    install -m 0644 ${WORKDIR}/aktualizr-lite.service ${D}${systemd_system_unitdir}/
}

RDEPENDS_${PN}-lite = "aktualizr-configs lshw"
