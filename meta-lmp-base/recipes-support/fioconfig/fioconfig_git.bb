DESCRIPTION = "A daemon to handle configuration management for devices in a Foundries Factory"
HOMEPAGE = "https://github.com/foundriesio/fioconfig"
SECTION = "devel"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://src/${GO_IMPORT}/LICENSE;md5=2a944942e1496af1886903d274dedb13"

GO_IMPORT = "github.com/foundriesio/fioconfig"
GO_IMPORT_PROTO ?= "https"
SRC_URI = "git://${GO_IMPORT};protocol=${GO_IMPORT_PROTO} \
	file://fioconfig.service \
	file://fioconfig.path \
	file://fioconfig-extract.service \
"
SRCREV = "8687ad01cf015376b57a6efc1c9f317aba2f0db0"

UPSTREAM_CHECK_COMMITS = "1"

inherit go-mod systemd

GOBUILDFLAGS += '-tags vpn -ldflags="-X ${GO_IMPORT}/internal.Commit=${SRCREV}"'
GO_LINKSHARED = ""

SYSTEMD_PACKAGES += "${PN}"
SYSTEMD_SERVICE_${PN} = "fioconfig.service fioconfig-extract.service fioconfig.path"


do_install_append() {
	install -d ${D}${systemd_system_unitdir}
	install -m 0644 ${WORKDIR}/fioconfig.service ${D}${systemd_system_unitdir}/
	install -m 0644 ${WORKDIR}/fioconfig.path ${D}${systemd_system_unitdir}/
	install -m 0644 ${WORKDIR}/fioconfig-extract.service ${D}${systemd_system_unitdir}/
	install -d ${D}${datadir}/fioconfig/handlers
	install -m 0755 ${S}/src/${GO_IMPORT}/contrib/aktualizr-toml-update ${D}${datadir}/fioconfig/handlers
	install -m 0755 ${S}/src/${GO_IMPORT}/contrib/factory-config-vpn ${D}${datadir}/fioconfig/handlers
}

# We need aktualizr because we uses its device gateway connectivity and keys,
# and networkmanager-nmcli for wireguard support
RDEPENDS_${PN} = "${SOTA_CLIENT} networkmanager-nmcli"

FILES_${PN} += " \
	${systemd_unitdir}/system/fioconfig.service \
	${systemd_unitdir}/system/fioconfig.path \
	${systemd_unitdir}/system/fioconfig-extract.service \
	${datadir}/fioconfig/handlers \
"
