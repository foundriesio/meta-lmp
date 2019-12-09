SUMMARY = "Setup BT 6LoWPAN network / modules"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COMMON_LICENSE_DIR}/MIT;md5=0835ade698e0bcf8506ecda2f7b4f302"

inherit allarch

SRC_URI = " \
	file://bt-6lowpan.network.in \
	file://modules-6lowpan.conf \
"

S = "${WORKDIR}"

PACKAGE_ARCH = "${MACHINE_ARCH}"

# Allow build time customizations by the user
BT_6LOWPAN_INTERFACE ?= "bt0"
BT_6LOWPAN_NETWORK ?= ""

do_compile() {
	if [ ! -z "${BT_6LOWPAN_NETWORK}" ]; then
		sed -e 's/@@BT_6LOWPAN_NETWORK@@/${BT_6LOWPAN_NETWORK}/' \
			${S}/bt-6lowpan.network.in > bt-6lowpan.network
	fi
}

do_install() {
	if [ -f "${S}/bt-6lowpan.network" ]; then
		install -d ${D}${systemd_unitdir}/network
		install -m 0644 ${B}/bt-6lowpan.network ${D}${systemd_unitdir}/network/60-bt-6lowpan.network
	fi
	install -d ${D}${libdir}/modules-load.d
	install -m 0644 ${WORKDIR}/modules-6lowpan.conf ${D}${libdir}/modules-load.d/6lowpan.conf
}

FILES_${PN} += "${libdir}/modules-load.d"
