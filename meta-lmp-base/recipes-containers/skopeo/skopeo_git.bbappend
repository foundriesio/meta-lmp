FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://docker-config-support-default-system-config.patch;patchdir=src/import"
