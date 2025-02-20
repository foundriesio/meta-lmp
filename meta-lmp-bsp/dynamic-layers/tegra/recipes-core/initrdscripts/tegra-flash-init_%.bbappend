FILESEXTRAPATHS:prepend := "${THISDIR}/${PN}:"

SRC_URI:append:tegra194 = " file://add-format-mmc-support.patch"
