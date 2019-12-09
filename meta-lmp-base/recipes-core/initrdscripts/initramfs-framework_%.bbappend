FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += " \
	file://ostree \
"

SRC_URI_append_sota += " \
	file://run-tmpfs.patch \
"

PACKAGES_append = " initramfs-module-ostree"

SUMMARY_initramfs-module-ostree = "initramfs support for ostree based filesystems"
RDEPENDS_initramfs-module-ostree = "${PN}-base ostree-switchroot"
FILES_initramfs-module-ostree = "/init.d/98-ostree"

do_install_append() {
	install -m 0755 ${WORKDIR}/ostree ${D}/init.d/98-ostree
}
