FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://cli-config-support-default-system-config.patch;patchdir=src/github.com/docker/cli"
