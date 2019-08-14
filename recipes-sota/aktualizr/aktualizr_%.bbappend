FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_lmp = " \
    file://Move-default-sota-config-from-usr-lib-to-var.patch \
    file://0001-FIO-toup-aktualizr-lite-Mock-OstreeManager-getCurren.patch \
    file://0002-FIO-toup-aktualizr-lite-Save-installed-version-targe.patch \
    file://0003-FIO-toup-aktualizr-lite-Use-current-target-for-statu.patch \
    file://0004-FIO-toup-docker-apps-Add-support-for-getCurrent.patch \
    file://0005-FIO-toup-aktualizr-lite-Rename-version-to-helpers.patch \
    file://0006-config-Add-notion-of-tags-to-package-manager.patch \
    file://0007-aktualizr-lite-Include-ostree-hash-in-request-header.patch \
    file://0008-aktualizr-lite-Add-targets-equal-helper.patch \
    file://0009-aktualizr-lite-Add-a-daemon-mode.patch \
    file://0010-aktualizr-lite-Add-ability-to-reboot-after-an-update.patch \
    file://0011-aktualizr-lite-Add-lockfile-for-daemon-mode-updates.patch \
    file://0012-Create-new-aktualizr-get-command.patch \
    file://0013-aktualizr-lite-Fix-incorrect-storing-of-ecu-hwid.patch \
    file://aktualizr-lite.service \
    file://increase-restartsec-service.patch;patchdir=.. \
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
