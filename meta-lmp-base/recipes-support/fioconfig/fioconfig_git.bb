DESCRIPTION = "A daemon to handle configuration management for devices in a Foundries Factory"
HOMEPAGE = "https://github.com/foundriesio/fioconfig"
SECTION = "devel"
LICENSE = "BSD-3-Clause"
LIC_FILES_CHKSUM = "file://src/${GO_IMPORT}/LICENSE;md5=504a5c2455c8bb2fc5b7667833ab1a68"

GO_IMPORT = "github.com/foundriesio/fioconfig"
GO_IMPORT_PROTO ?= "https"
SRC_URI = "git://${GO_IMPORT};protocol=${GO_IMPORT_PROTO};branch=v94 \
	file://fioconfig.service \
	file://fioconfig.path \
	file://fioconfig-extract.service \
"
SRCREV = "62170c1344a7d3651c85354988677b77053d8ea1"

UPSTREAM_CHECK_COMMITS = "1"

inherit go-mod systemd

# Extend from go.bbclass to include internal.Commit and tags
GO_LDFLAGS += "-tags vpn"
GO_EXTRA_LDFLAGS = "-X ${GO_IMPORT}/internal.Commit=${SRCREV}"

SYSTEMD_SERVICE:${PN} = "fioconfig.service fioconfig-extract.service fioconfig.path"


do_install:append() {
	install -d ${D}${systemd_system_unitdir}
	install -m 0644 ${WORKDIR}/fioconfig.service ${D}${systemd_system_unitdir}/
	install -m 0644 ${WORKDIR}/fioconfig.path ${D}${systemd_system_unitdir}/
	install -m 0644 ${WORKDIR}/fioconfig-extract.service ${D}${systemd_system_unitdir}/
	install -d ${D}${datadir}/fioconfig/handlers
	install -m 0755 ${S}/src/${GO_IMPORT}/contrib/aktualizr-toml-update ${D}${datadir}/fioconfig/handlers
	install -m 0755 ${S}/src/${GO_IMPORT}/contrib/factory-config-vpn ${D}${datadir}/fioconfig/handlers
	install -m 0755 ${S}/src/${GO_IMPORT}/contrib/renew-client-cert ${D}${datadir}/fioconfig/handlers
	sed -i -e "s/SOTA_CLIENT=aktualizr-lite/SOTA_CLIENT=${SOTA_CLIENT}/g" \
		 ${D}${datadir}/fioconfig/handlers/aktualizr-toml-update
}

# We need aktualizr because we uses its device gateway connectivity and keys,
# and networkmanager-nmcli for wireguard support
RDEPENDS:${PN} = "${SOTA_CLIENT} networkmanager-nmcli"

FILES:${PN} += " \
	${systemd_system_unitdir}/fioconfig.service \
	${systemd_system_unitdir}/fioconfig.path \
	${systemd_system_unitdir}/fioconfig-extract.service \
	${datadir}/fioconfig/handlers \
"
