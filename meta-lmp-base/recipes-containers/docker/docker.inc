DEPENDS = " \
    go-cli \
    go-pty \
    go-context \
    go-mux \
    go-patricia \
    go-logrus \
    go-fsnotify \
    go-dbus \
    go-capability \
    go-systemd \
    btrfs-tools \
    sqlite3 \
    go-distribution \
    compose-file \
    go-connections \
    notary \
    grpc-go \
    libtool-native \
    libtool \
    "

DEPENDS_append_class-target = " lvm2"
RDEPENDS_${PN} = "util-linux util-linux-unshare iptables \
                  ${@bb.utils.contains('DISTRO_FEATURES', 'aufs', 'aufs-util', '', d)} \
                  ${@bb.utils.contains('DISTRO_FEATURES', 'systemd', '', 'cgroup-lite', d)} \
                  bridge-utils \
                  ca-certificates \
                 "
RDEPENDS_${PN} += "virtual/containerd virtual/runc"

RRECOMMENDS_${PN} = "kernel-module-dm-thin-pool kernel-module-nf-nat kernel-module-xt-addrtype"

PROVIDES += "virtual/docker"

# we want all the docker variant recpes to be installable via "docker"
PACKAGE_NAME = "docker"
RPROVIDES_${PN} += "docker"
RPROVIDES_${PN}-dbg += "docker-dbg"
RPROVIDES_${PN}-dev += "docker-dev"
RPROVIDES_${PN}-contrip += "docker-dev"

inherit pkgconfig
PACKAGECONFIG ??= "docker-init"
PACKAGECONFIG[seccomp] = "seccomp,,libseccomp"
PACKAGECONFIG[docker-init] = ",,,docker-init"
PACKAGECONFIG[transient-config] = "transient-config"

inherit systemd update-rc.d

SYSTEMD_PACKAGES = "${@bb.utils.contains('DISTRO_FEATURES','systemd','${PN}','',d)}"
SYSTEMD_SERVICE_${PN} = "${@bb.utils.contains('DISTRO_FEATURES','systemd','docker.socket','',d)}"
SYSTEMD_AUTO_ENABLE_${PN} = "enable"

INITSCRIPT_PACKAGES += "${@bb.utils.contains('DISTRO_FEATURES','sysvinit','${PN}','',d)}"
INITSCRIPT_NAME_${PN} = "${@bb.utils.contains('DISTRO_FEATURES','sysvinit','docker.init','',d)}"
INITSCRIPT_PARAMS_${PN} = "defaults"

inherit useradd
USERADD_PACKAGES = "${PN}"
GROUPADD_PARAM_${PN} = "-r docker"

COMPATIBLE_HOST = "^(?!(qemu)?mips).*"

INSANE_SKIP_${PN} += "ldflags textrel"
