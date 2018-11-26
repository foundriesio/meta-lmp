FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append += " \
    file://Move-default-sota-config-from-usr-lib-to-var.patch \
    file://aktualizr-info-add-support-to-report-current-image-h.patch \
    file://ostreemanager-tag-run-aktualizr-ostree-pending-update.patch \
    file://storage_config-force-sqlite-storage-backend.patch \
    file://increase-restartsec-service.patch;patchdir=.. \
"
