FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# PIE is still not fully working with 18.03 (e.g. arm64), so disable by default
GOBUILDFLAGS_remove = "-buildmode=pie"

SRC_URI_append = " \
    file://dockerd-daemon-use-default-system-config-when-none-i.patch \
    file://daemon.json \
"

do_install_append() {
    install -d ${D}${libdir}/docker
    install -m 0644 ${WORKDIR}/daemon.json ${D}${libdir}/docker/
}
