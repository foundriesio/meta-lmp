FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# Remove CVE-2021-27138 fixes when using '@' as fit separator
SRC_URI:remove = '${@oe.utils.conditional("FIT_NODE_SEPARATOR", "@", "\
	file://CVE-2021-27138-1.patch \
	file://CVE-2021-27138-2.patch", "", d)}'
