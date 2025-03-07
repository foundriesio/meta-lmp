FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

BRANCH:lmp = "v95"
SRCREV:lmp = "9d0d1306132bc0ec5b27afe6d164045d1675bc54"

SRC_URI:remove:lmp = "gitsm://github.com/uptane/aktualizr;branch=${BRANCH};name=aktualizr;protocol=https"
SRC_URI:append:lmp = " \
    gitsm://github.com/foundriesio/aktualizr-lite;protocol=https;branch=${BRANCH};name=aktualizr \
    file://aktualizr-lite.service.in \
    file://tmpfiles.conf \
    "

PACKAGECONFIG += "${@bb.utils.filter('MACHINE_FEATURES', 'fiovb', d)} ${@bb.utils.filter('MACHINE_FEATURES', 'fioefi', d)} libfyaml"
PACKAGECONFIG[fiovb] = ",,,optee-fiovb aktualizr-fiovb-env-rollback,,fioefi"
PACKAGECONFIG[fioefi] = ",,,fioefi aktualizr-fioefi-env-rollback,,fiovb"
PACKAGECONFIG[ubootenv] = ",,u-boot-fw-utils,u-boot-fw-utils u-boot-default-env aktualizr-uboot-env-rollback"
PACKAGECONFIG[libfyaml] = ",,,libfyaml"
PACKAGECONFIG[aklite-offline] = "-DBUILD_AKLITE_OFFLINE=ON,-DBUILD_AKLITE_OFFLINE=OFF,"
PACKAGECONFIG[hsm] = "-DBUILD_P11=ON -DPKCS11_ENGINE_PATH=${PKCS11_ENGINE_PATH},-DBUILD_P11=OFF,libp11,aktualizr-pkcs11-label"
PACKAGECONFIG[auto-downgrade] = "-DAUTO_DOWNGRADE=ON"

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
    # asn1c tool places the full absolute path for the asn1 file at the header comment of the generated source files
    # pdu_collection.c also lists, as comments, the reference asn1 files paths
    # Making the paths in the comments relative to ${S} avoids Yocto TMPDIR reference warnings
    sed -i "s|${S}/||g" ${B}/aktualizr/src/libaktualizr-posix/asn1/generated/asn1/*.[ch]
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

PACKAGES += "${PN}-get \
             ${PN}-lite \
             ${PN}-lite-lib \
             ${PN}-lite-dev \
             ${@bb.utils.contains('PACKAGECONFIG', 'aklite-offline', '${PN}-lite-offline', '', d)} \
"

FILES:${PN}-get = "${bindir}/${PN}-get"
FILES:${PN}-lite = " \
                    ${bindir}/${PN}-lite \
                    ${nonarch_libdir}/tmpfiles.d/${PN}-lite.conf \
                    "
FILES:${PN}-lite-lib = "${nonarch_libdir}/lib${PN}_lite.so"
FILES:${PN}-lite-dev = "${includedir}/${PN}-lite"
FILES:${PN}-lite-offline = "${bindir}/aklite-offline"

# Force same RDEPENDS, packageconfig rdepends common to both
RDEPENDS:${PN}-lite = "\
    ${RDEPENDS:aktualizr} \
    ${@bb.utils.contains('PACKAGECONFIG', 'aklite-offline', '${PN}-lite-offline', '', d)} \
"
RDEPENDS:${PN}-lite-lib = "${RDEPENDS:aktualizr} composectl"
