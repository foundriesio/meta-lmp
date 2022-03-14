DESCRIPTION = "Enables foundries.io aktualizr-lite public stream updates"
HOMEPAGE = "https://github.com/foundriesio/meta-lmp"
SECTION = "base"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

inherit allarch

SRC_URI = "file://10-lite-public-stream.toml.in"

S = "${WORKDIR}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

AKLITE_TAG ?= "promoted"

do_compile() {
	sed -e 's/@@AKLITE_TAG@@/${AKLITE_TAG}/' \
		${WORKDIR}/10-lite-public-stream.toml.in > 10-lite-public-stream.toml
}

do_install() {
	install -m 0700 -d ${D}${libdir}/sota/conf.d
	install -m 0644 ${WORKDIR}/10-lite-public-stream.toml ${D}${libdir}/sota/conf.d/10-lite-public-stream.toml
}

FILES:${PN} += "${libdir}/sota/conf.d/10-lite-public-stream.toml"
