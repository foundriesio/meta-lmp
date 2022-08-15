FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = " \
	file://ostree \
	file://ostree_factory_reset \
	file://ostree_recovery \
	file://run-tmpfs.patch \
"

PACKAGES:append = " \
	initramfs-module-ostree \
	initramfs-module-ostree-factory-reset \
	initramfs-module-ostree-recovery \
"

SUMMARY:initramfs-module-ostree = "initramfs support for ostree based filesystems"
RDEPENDS:initramfs-module-ostree = "${PN}-base ostree-switchroot"
FILES:initramfs-module-ostree = "/init.d/98-ostree"

SUMMARY:initramfs-module-ostree-factory-reset = "initramfs support for ostree based filesystems"
RDEPENDS:initramfs-module-ostree-factory-reset = "${PN}-base ostree-switchroot"
FILES:initramfs-module-ostree-factory-reset = "/init.d/98-ostree_factory_reset"

SUMMARY:initramfs-module-ostree-recovery = "recovery initramfs for ostree based filesystems"
RDEPENDS:initramfs-module-ostree-recovery = "${PN}-base ostree"
FILES:initramfs-module-ostree-recovery = "/init.d/98-ostree_recovery /recovery.d"

do_install:append() {
	install -d ${D}/recovery.d
	install -m 0755 ${WORKDIR}/ostree ${D}/init.d/98-ostree
	install -m 0755 ${WORKDIR}/ostree_factory_reset ${D}/init.d/98-ostree_factory_reset
	install -m 0755 ${WORKDIR}/ostree_recovery ${D}/init.d/98-ostree_recovery
}
