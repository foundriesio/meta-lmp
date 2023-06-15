FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
    file://docker-config-support-default-system-config.patch;patchdir=src/import \
    file://0001-cmd-copy-max-parallel-pulls-param.patch;patchdir=src/import \
    file://0002-dont-store-signatures-if-none-is-present.patch;patchdir=src/import \
"
