FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

# Prefer gptfdisk instead of parted
RDEPENDS:${PN}:remove = "parted dosfstools"
RDEPENDS:${PN} += "efibootmgr gptfdisk"
