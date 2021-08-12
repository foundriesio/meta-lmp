FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

# Remove CVE-2021-27138 fixes when using '@' as fit separator
SRC_URI_remove = '${@oe.utils.conditional("FIT_NODE_SEPARATOR", "@", "\
	file://CVE-2021-27138-1.patch \
	file://CVE-2021-27138-2.patch", "", d)}'

SRC_URI += "file://0001-tools-image-host-fix-wrong-return-value.patch"
