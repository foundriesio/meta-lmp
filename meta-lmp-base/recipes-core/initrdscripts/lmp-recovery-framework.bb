SUMMARY = "Linux microPlatform recovery modules"
LICENSE = "MIT"
LIC_FILES_CHKSUM = "file://COPYING.MIT;md5=838c366f69b72c5df05c96dff79b35f2"

inherit allarch

SRC_URI = " \
	file://uboot_env \
	file://udhcpc \
	file://image_download"

S = "${WORKDIR}"

do_install() {
	install -d ${D}/recovery.d
	install -m 0755 ${WORKDIR}/uboot_env.sh ${D}/recovery.d/10-uboot_env
	install -m 0755 ${WORKDIR}/udhcpc.sh ${D}/recovery.d/20-udhcpc
	install -m 0755 ${WORKDIR}/image_download.sh ${D}/recovery.d/30-image_download
}

PACKAGES = " \
	lmp-recovery-module-sample-uboot-env \
	lmp-recovery-module-sample-udhcpc \
	lmp-recovery-module-sample-image-download"

SUMMARY:lmp-recovery-module-sample-uboot-env = "u-boot sample for LmP recovery initramfs"
RDEPENDS:lmp-recovery-module-sample-uboot-env = "initramfs-module-ostree-recovery u-boot-default-env u-boot-fw-utils"
FILES:lmp-recovery-module-sample-uboot-env = "/recovery.d/10-uboot_env"

SUMMARY:lmp-recovery-module-sample-udhcpc = "udhcpc sample for LmP recovery initramfs"
RDEPENDS:lmp-recovery-module-sample-udhcpc = "initramfs-module-ostree-recovery busybox-udhcpc"
FILES:lmp-recovery-module-sample-udhcpc = "/recovery.d/20-udhcpc"

SUMMARY:lmp-recovery-module-sample-image-download = "u-boot sample for LmP recovery initramfs"
RDEPENDS:lmp-recovery-module-sample-image-download = "initramfs-module-ostree-recovery os-release"
FILES:lmp-recovery-module-sample-image-download = "/recovery.d/30-image_download"
