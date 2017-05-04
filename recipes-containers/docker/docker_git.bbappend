FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
INHIBIT_PACKAGE_STRIP = "0"

# Additional bugfixes already available upstream
SRC_URI += " \
    file://0001-Add-on-failure-to-default-restart-policy.patch \
    file://0001-bugfix-issie-18826-containers-do-not-restart-after-r.patch \
"
