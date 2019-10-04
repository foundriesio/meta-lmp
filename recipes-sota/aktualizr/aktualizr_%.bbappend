FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_lmp = " \
    file://Move-default-sota-config-from-usr-lib-to-var.patch \
    file://0001-SQL-Add-a-new-column-to-store-custom-data-for-Target.patch \
    file://0002-storage-Load-save-custom-data-with-installed-version.patch \
    file://0003-sotauptaneclient-Expose-pacman-verifyTarget.patch \
    file://0004-dockerapp-Check-verifyTarget-no-matter-what.patch \
    file://0005-dockerapp-Fix-docker-app-invocation.patch \
    file://0006-aktualizr-lite-Rename-version-to-helpers.patch \
    file://0007-aktualizr-lite-Add-some-testing-for-liteClient-helpe.patch \
    file://0008-aktualizr-lite-Introduce-a-LiteClient.patch \
    file://0009-config-Add-notion-of-tags-to-package-manager.patch \
    file://0010-aktualizr-lite-Include-passive-status-headers.patch \
    file://0011-aktualizr-lite-Add-targets-equal-helper.patch \
    file://0012-aktualizr-lite-Add-a-daemon-mode.patch \
    file://0013-aktualizr-lite-Add-ability-to-reboot-after-an-update.patch \
    file://0014-aktualizr-lite-Add-lockfile-for-daemon-mode-updates.patch \
    file://0015-aktualizr-lite-Start-sending-events-during-updates.patch \
    file://0016-aktualizr-lite-Add-reporting-of-network-info.patch \
    file://0017-fiotup-httpclient-Expose-method-to-update-headers.patch \
    file://0018-fiotoup-aktualizr-lite-Detect-when-reboot-isn-t-need.patch \
    file://0019-Allow-aktualizr-get-to-log-to-stderr.patch \
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

RDEPENDS_${PN}-lite = "aktualizr-configs lshw"
