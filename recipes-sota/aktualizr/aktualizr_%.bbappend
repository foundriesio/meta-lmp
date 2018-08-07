FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append += " \
    file://Move-default-sota-config-from-usr-lib-to-var.patch \
    file://aktualizr-info-add-support-to-report-current-image-h.patch \
    file://ostreemanager-tag-run-aktualizr-ostree-pending-update.patch \
    file://storage_config-force-sqlite-storage-backend.patch \
    file://increase-restartsec-service.patch;patchdir=.. \
    file://20-provision-hardware-id.toml \
"

do_install_append() {
    install -m 0700 -d ${D}${libdir}/sota/conf.d
    install -m 0644 ${WORKDIR}/20-provision-hardware-id.toml ${D}${libdir}/sota/conf.d
    sed -i -e 's/@MACHINE@/${MACHINE}/g' ${D}${libdir}/sota/conf.d/20-provision-hardware-id.toml
}
