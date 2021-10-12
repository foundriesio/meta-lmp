DESCRIPTION = "FIT image boot script for launching OSTree based images with u-boot"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

INHIBIT_DEFAULT_DEPS = "1"

DEPENDS = "dtc-native u-boot-mkimage-native"

SRC_URI = "file://boot.cmd \
	file://boot-common.cmd.in \
	file://boot-common-imx.cmd.in \
	file://boot.its.in \
"

S = "${WORKDIR}"
B = "${WORKDIR}/build"

# fitImage Hash Algo
FIT_HASH_ALG ?= "sha256"

# Allow transition to cover CVE-2021-27097 and CVE-2021-27138
FIT_NODE_SEPARATOR ?= "-"

inherit deploy

do_configure[noexec] = "1"

do_compile() {
	sed -e '/@@INCLUDE_COMMON_IMX@@/ {' -e 'r ${S}/boot-common-imx.cmd.in' -e 'd' -e '}' \
			"${S}/boot.cmd" > boot.cmd.in
	sed -i -e '/@@INCLUDE_COMMON@@/ {' -e 'r ${S}/boot-common.cmd.in' -e 'd' -e '}' \
			boot.cmd.in
	sed -e 's/@@FIT_NODE_SEPARATOR@@/${FIT_NODE_SEPARATOR}/g' \
			boot.cmd.in > boot.cmd
	sed -e 's/@@FIT_HASH_ALG@@/${FIT_HASH_ALG}/' \
	    -e 's/@@UBOOT_SIGN_KEYNAME@@/${UBOOT_SIGN_KEYNAME}/' \
			"${S}/boot.its.in" > boot.its
	uboot-mkimage -f boot.its -r boot.itb
	if [ "x${UBOOT_SIGN_ENABLE}" = "x1" ]; then
		uboot-mkimage -F -k "${UBOOT_SIGN_KEYDIR}" -r boot.itb
	fi
}

do_install() {
	install -d ${D}${datadir}/${BPN}
	install -m 0644 boot.cmd ${D}${datadir}/${BPN}
	install -m 0644 boot.itb ${D}${datadir}/${BPN}
}

do_deploy() {
	install -d ${DEPLOYDIR}
	install -m 0644 boot.cmd ${DEPLOYDIR}
	install -m 0644 boot.itb ${DEPLOYDIR}
}

addtask do_deploy before do_build after do_install

PACKAGE_ARCH = "${MACHINE_ARCH}"

PROVIDES += "u-boot-default-script"
