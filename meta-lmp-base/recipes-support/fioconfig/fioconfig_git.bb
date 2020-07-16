DESCRIPTION = "A daemon to handle configuration management for devices in a Foundries Factory"
HOMEPAGE = "https://github.com/foundriesio/fioconfig"
SECTION = "devel"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://src/${GO_IMPORT}/LICENSE;md5=2a944942e1496af1886903d274dedb13"

GO_IMPORT = "github.com/foundriesio/fioconfig"
SRC_URI = "git://${GO_IMPORT} \
	file://fioconfig.service \
	file://fioconfig.path \
	file://fioconfig-extract.service \
"
SRCREV = "9713f2bdf86a9765ae7ad15252fb68638d76b38c"

UPSTREAM_CHECK_COMMITS = "1"

inherit go goarch systemd

do_compile() {
	cd ${S}/src/${GO_IMPORT}
	BUILD_COMMIT=`git rev-parse --short HEAD`
	FIOCONFIG_LDFLAGS="-X ${GO_IMPORT}/internal.Commit=${BUILD_COMMIT}"
	mkdir -p ${B}/${GO_BUILD_BINDIR}
	${GO} build -tags vpn -ldflags="${FIOCONFIG_LDFLAGS}" -o ${B}/${GO_BUILD_BINDIR}/fioconfig main.go
	chmod u+w -R ${B}
}

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

# We need aktualizr because we uses its device gateway connectivity and keys
RDEPENDS_${PN} = "${SOTA_CLIENT}"

FILES_${PN} += " \
	${systemd_unitdir}/system/fioconfig.service \
	${systemd_unitdir}/system/fioconfig.path \
	${systemd_unitdir}/system/fioconfig-extract.service \
	${datadir}/fioconfig/handlers \
"
