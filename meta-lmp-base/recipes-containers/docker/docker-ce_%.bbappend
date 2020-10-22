FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

require docker-lmp.inc

# The patch that adds configurable maximum of download attempts originates
# from https://github.com/docker/docker-ce/commit/74d15487080abcfce9d9359a746620a7f7c06c5b
SRC_URI_append = " \
    file://dockerd-daemon-use-default-system-config-when-none-i.patch \
    file://cli-config-support-default-system-config.patch \
    file://dockerd-daemon-configurable-max-download-attempts.patch \
    file://fix-warning-systemd-docker-socket.patch \
    file://increase_containerd_timeouts.patch \
"
