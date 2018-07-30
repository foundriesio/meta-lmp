FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append += " \
    file://Move-default-sota-config-from-usr-lib-to-var.patch \
    file://aktualizr-info-add-support-to-report-current-image-h.patch \
    file://ostreemanager-tag-run-aktualizr-ostree-pending-update.patch \
    file://increase-restartsec-service.patch;patchdir=.. \
"

do_install_append() {
    cat >> ${D}/${libdir}/sota/sota_implicit_prov.toml << EOF

[uptane]
primary_ecu_hardware_id = "${MACHINE}"
EOF
}
