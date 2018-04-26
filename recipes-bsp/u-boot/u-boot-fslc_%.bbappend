FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append += " \
	file://OSF-toup-mx6cuboxi-detect-som-revision-for-cubox-i-a.patch \
"

RDEPENDS_${PN}_append_sota = " u-boot-ostree-scr"
