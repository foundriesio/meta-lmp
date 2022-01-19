FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
	file://ostree \
	file://ostree_factory_reset \
	file://run-tmpfs.patch \
"

PACKAGES:append = " initramfs-module-ostree initramfs-module-ostree-factory-reset"

SUMMARY:initramfs-module-ostree = "initramfs support for ostree based filesystems"
RDEPENDS:initramfs-module-ostree = "${PN}-base ostree-switchroot"
FILES:initramfs-module-ostree = "/init.d/98-ostree"

SUMMARY:initramfs-module-ostree-factory-reset = "initramfs support for ostree based filesystems"
RDEPENDS:initramfs-module-ostree-factory-reset = "${PN}-base ostree-switchroot"
FILES:initramfs-module-ostree-factory-reset = "/init.d/98-ostree_factory_reset"

do_install:append() {
	install -m 0755 ${WORKDIR}/ostree ${D}/init.d/98-ostree
	install -m 0755 ${WORKDIR}/ostree_factory_reset ${D}/init.d/98-ostree_factory_reset
}
