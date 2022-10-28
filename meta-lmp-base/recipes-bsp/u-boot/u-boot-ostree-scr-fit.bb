DESCRIPTION = "FIT image boot script for launching OSTree based images with u-boot"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/COPYING.MIT;md5=3da9cfbcb788c80a0384361b4de20420"

INHIBIT_DEFAULT_DEPS = "1"

DEPENDS = "dtc-native u-boot-mkimage-native"

SRC_URI = "file://boot.cmd \
	file://env-common.cmd.in \
	file://boot-common.cmd.in \
	file://boot-common-imx.cmd.in \
	file://boot-common-alternative.cmd.in \
	file://boot.its.in \
"

SRC_URI:append = " ${@'file://update.cmd file://update.its.in file://update-common.cmd.in' if (d.getVar('LMP_BOOT_FIRMWARE_FILES') != '') else '' }"

S = "${WORKDIR}"
B = "${WORKDIR}/build"

# fitImage Hash Algo
FIT_HASH_ALG ?= "sha256"

# Allow transition to cover CVE-2021-27097 and CVE-2021-27138
FIT_NODE_SEPARATOR ?= "-"

inherit deploy

do_configure[noexec] = "1"

do_compile() {
	sed -e '/@@INCLUDE_ENV_COMMON@@/ {' -e 'r ${S}/env-common.cmd.in' -e 'd' -e '}' \
			"${S}/boot-common.cmd.in" > boot-common.cmd.in
	sed -e '/@@INCLUDE_COMMON_IMX@@/ {' -e 'r ${S}/boot-common-imx.cmd.in' -e 'd' -e '}' \
			"${S}/boot.cmd" > boot.cmd.in
	sed -i -e '/@@INCLUDE_COMMON@@/ {' -e 'r ${B}/boot-common.cmd.in' -e 'd' -e '}' \
			boot.cmd.in
	sed -i -e '/@@INCLUDE_COMMON_ALTERNATIVE@@/ {' -e 'r ${S}/boot-common-alternative.cmd.in' -e 'd' -e '}' \
			boot.cmd.in
	sed -e 's/@@FIT_NODE_SEPARATOR@@/${FIT_NODE_SEPARATOR}/g' \
	    -e 's/@@OSTREE_SPLIT_BOOT@@/${OSTREE_SPLIT_BOOT}/g' \
	    -e 's/@@OSTREE_DEPLOY_USR_OSTREE_BOOT@@/${OSTREE_DEPLOY_USR_OSTREE_BOOT}/g' \
			boot.cmd.in > boot.cmd
	sed -e 's/@@FIT_HASH_ALG@@/${FIT_HASH_ALG}/' \
	    -e 's/@@UBOOT_SIGN_KEYNAME@@/${UBOOT_SIGN_KEYNAME}/' \
			"${S}/boot.its.in" > boot.its
	uboot-mkimage -f boot.its -r boot.itb
	if [ "x${UBOOT_SIGN_ENABLE}" = "x1" ]; then
		uboot-mkimage -F -k "${UBOOT_SIGN_KEYDIR}" -r boot.itb
	fi

	if [ -n "${LMP_BOOT_FIRMWARE_FILES}" ]; then
		sed -e '/@@INCLUDE_ENV_COMMON@@/ {' -e 'r ${S}/env-common.cmd.in' -e 'd' -e '}' \
				"${S}/update-common.cmd.in" > update-common.cmd.in
		sed -e '/@@INCLUDE_UPDATE_COMMON_IMX@@/ {' -e 'r ${S}/update-common-imx.cmd.in' -e 'd' -e '}' \
				"${S}/update.cmd" > update.cmd.in
		sed -i -e '/@@INCLUDE_UPDATE_COMMON@@/ {' -e 'r ${B}/update-common.cmd.in' -e 'd' -e '}' \
				update.cmd.in
		sed -i -e '/@@INCLUDE_UPDATE_COMMON_ALTERNATIVE@@/ {' -e 'r ${S}/update-common-alternative.cmd.in' -e 'd' -e '}' \
				update.cmd.in
		sed -e 's/@@FIT_NODE_SEPARATOR@@/${FIT_NODE_SEPARATOR}/g' \
		    -e 's/@@OSTREE_SPLIT_BOOT@@/${OSTREE_SPLIT_BOOT}/g' \
		    -e 's/@@OSTREE_DEPLOY_USR_OSTREE_BOOT@@/${OSTREE_DEPLOY_USR_OSTREE_BOOT}/g' \
				update.cmd.in > update.cmd
		sed -e 's/@@FIT_HASH_ALG@@/${FIT_HASH_ALG}/' \
		    -e 's/@@UBOOT_SIGN_KEYNAME@@/${UBOOT_SIGN_KEYNAME}/' \
				"${S}/update.its.in" > update.its
		uboot-mkimage -f update.its -r update.itb
		if [ "x${UBOOT_SIGN_ENABLE}" = "x1" ]; then
			uboot-mkimage -F -k "${UBOOT_SIGN_KEYDIR}" -r update.itb
		fi
	fi
}

do_install() {
	install -d ${D}${datadir}/${BPN}
	install -m 0644 boot.cmd ${D}${datadir}/${BPN}
	install -m 0644 boot.itb ${D}${datadir}/${BPN}
	if [ -n "${LMP_BOOT_FIRMWARE_FILES}" ]; then
		install -m 0644 update.cmd ${D}${datadir}/${BPN}
		install -m 0644 update.itb ${D}${datadir}/${BPN}
	fi
}

do_deploy() {
	install -d ${DEPLOYDIR}
	install -m 0644 boot.cmd ${DEPLOYDIR}
	install -m 0644 boot.itb ${DEPLOYDIR}
	if [ -n "${LMP_BOOT_FIRMWARE_FILES}" ]; then
		install -m 0644 update.cmd ${DEPLOYDIR}
		install -m 0644 update.itb ${DEPLOYDIR}
	fi
}

addtask do_deploy before do_build after do_install

PACKAGE_ARCH = "${MACHINE_ARCH}"

PROVIDES += "u-boot-default-script"
RPROVIDES:${PN} += "u-boot-default-script"
