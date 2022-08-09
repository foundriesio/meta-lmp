FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append = "\
	file://cli-config-support-default-system-config.patch;patchdir=src/import/vendor.fetch/github.com/docker/cli \
	file://0001-extend-ps-output.patch;patchdir=src/import \
	"

RDEPENDS:${PN} += "cni"
